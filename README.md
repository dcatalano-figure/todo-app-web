# Example web todo list

This is a simple web todo list for presentations and demos. It's written in Golang + Javascript.

## Building the image

### Compile the code

```bash
go get -u github.com/johscheuer/todo-app-web
```

#### On OSX

```bash
# install mod into vendor
go mod vendor
# build
CGO_ENABLED=0 go build -mod=vendor -o bin/todo-app .
```

## Testing

```bash
./integration_test.sh
```

## Usage

```text
Usage of bin/todo-app:
  -health-check int
           Period to check all connections (default 15)
  -master string
           The connection string to the Redis master as <hostname/ip>:<port> (default "redis-master:6379")
  -master-password string
           The password used to connect to the master
  -slave string
           The connection string to the Redis slave as <hostname/ip>:<port> (default "redis-slave:6379")
  -slave-password string
           The password used to connect to the slave
  -version
           Shows the version
```
