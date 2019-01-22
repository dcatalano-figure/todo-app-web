#
# ----- Go Builder Image ------
#
FROM golang:1.11-alpine AS builder

# set working directory
RUN mkdir -p /go/src/github.com/johscheuer/todo-app-web
WORKDIR /go/src/github.com/johscheuer/todo-app-web

# copy sources
COPY . .

# build binary
ENV GO111MODULE=on
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -mod=vendor -o /bin/todo-app .

#
# ----- Release Image ------
#
FROM alpine:3.8

COPY --from=builder /bin/todo-app /app/todo-app
COPY ./public /app/public

WORKDIR /app
CMD ["./todo-app"]
EXPOSE 3000
