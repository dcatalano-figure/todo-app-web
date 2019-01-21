#
# ----- Go Builder Image ------
#
FROM golang:1.11 AS builder

# set working directory
RUN mkdir -p /go/src/github.com/johscheuer/todo-app-web
WORKDIR /go/src/github.com/johscheuer/todo-app-web

# install delve
RUN go get -u github.com/go-delve/delve/cmd/dlv

# copy sources
COPY . .

# build binary with optiomization turned off
ENV GO111MODULE=on
RUN CGO_ENABLED=0 go build -mod=vendor -gcflags "-N -l"  -o /bin/todo-app .

#
# ----- Release Image ------
#
FROM alpine:3.8

# copy delve debugger binary
COPY --from=builder /go/bin/dlv /usr/local/bin/dlv

# copy app binary and static files
COPY --from=builder /bin/todo-app /app/todo-app
COPY ./public /app/public

WORKDIR /app
CMD ["dlv", "--headless=true", "exec", "./todo-app"]

# expose app port
EXPOSE 3000

# expose debugger port
EXPOSE 2345
