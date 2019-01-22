#
# ----- Go Builder Image ------
#
FROM golang:1.11-alpine AS builder

# install git
RUN apk add --no-cache git

# disable CGO
ENV CGO_ENABLED=0 

# set working directory
RUN mkdir -p /go/src/github.com/johscheuer/todo-app-web
WORKDIR /go/src/github.com/johscheuer/todo-app-web

# install delve
RUN go get -u github.com/go-delve/delve/cmd/dlv

# copy sources
COPY . .

# build binary
ENV GO111MODULE=on
RUN go build -gcflags="all=-N -l" -mod=vendor -o ./todo-app .

#
# ----- Release Image ------
#
FROM alpine:3.8

# set working directory
RUN mkdir -p /go/src/github.com/johscheuer/todo-app-web
WORKDIR /go/src/github.com/johscheuer/todo-app-web

COPY --from=builder /go/bin/dlv /usr/local/bin/dlv
COPY --from=builder /go/src/github.com/johscheuer/todo-app-web/ .

# expose app port
EXPOSE 3000
# expose debugger port
EXPOSE 2345

# delve debug command
CMD ["dlv", "exec", "--headless", "--api-version=2", "--listen=:2345", "--log", "./todo-app"]

