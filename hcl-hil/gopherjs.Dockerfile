FROM golang:1.12

WORKDIR /app

ADD go.mod ./
ADD go.sum ./
RUN go mod download
# RUN go build -o main . 
# RUN go get github.com/gopherjs/gopherjs
# RUN go get github.com/myitcv/gopherjs
SHELL [ "bash", "-c" ]
RUN git clone https://github.com/myitcv/gopherjs "$(cut -d':' -f1 <<< $GOPATH)/src/github.com/gopherjs/gopherjs" \
    && cd "$(cut -d':' -f1 <<< $GOPATH)/src/github.com/gopherjs/gopherjs" \
    && GO111MODULE=on go install
# RUN go get github.com/hashicorp/hcl2
# RUN go get github.com/hashicorp/hil
# RUN go get github.com/hashicorp/terraform/terraform@v0.12.0-rc1

ADD main.go ./
RUN gopherjs build main.go -o build.js -v

CMD ["cat", "build.js"]
