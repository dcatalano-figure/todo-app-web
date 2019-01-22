#
# ----- Go Builder Image ------
#
FROM golang:1.10-alpine AS builder

# install git
RUN apk add --no-cache git

# disable CGO
ENV CGO_ENABLED=0 

# set working directory
RUN mkdir -p /go/src/github.com/johscheuer/todo-app-web
WORKDIR /go/src/github.com/johscheuer/todo-app-web

# install delve
RUN go get -u github.com/go-delve/delve/cmd/dlv

# enable mod
#ENV GO111MODULE=on

# copy sources
COPY . .

# expose app port
EXPOSE 3000
# expose debugger port
EXPOSE 2345

# delve debug command
CMD ["dlv", "debug", "--headless", "--api-version=2", "--listen=:2345", "--log"]

