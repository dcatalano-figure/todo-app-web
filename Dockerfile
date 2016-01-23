FROM alpine:3.3

ADD ./bin/todo-app /app/todo-app
ADD ./public /app/public

WORKDIR /app
CMD ["./todo-app"]
EXPOSE 3000