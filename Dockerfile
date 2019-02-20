#
# ----- Go Builder Image ------
#
FROM golang:1.11-alpine AS builder

# install git
RUN apk add --no-cache git

# set working directory
RUN mkdir -p /app
WORKDIR /app

# copy sources
COPY . .

# build binary
RUN GO111MODULE=on CGO_ENABLED=0 go build -ldflags="-s -w -X main.appVersion=$(cat VERSION)" -o ./bin/todo-app .

#
# ----- Release Image ------
#
FROM alpine:3.8

COPY --from=builder /app/bin/todo-app /app/todo-app
COPY ./public /app/public

WORKDIR /app
CMD ["./todo-app"]
EXPOSE 3000
