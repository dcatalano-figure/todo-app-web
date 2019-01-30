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

### Debug in K8s

It's possible to debug the app inside a Kubernetes cluster using [Telepresence](https://www.telepresence.io/) tool.

Install Telepresence (on OS X):

```sh
brew cask install osxfuse
brew install datawire/blackbird/telepresence
```

Replace target deployment with Telepresence "proxy" running shell:

```sh
telepresence --namespace=todo-app --swap-deployment=todo-app --expose 3000 --run bash
```

Start a Delve debugger server and attach debugger client to it:

```sh
dlv debug --listen=localhost:2345 --headless=true --api-version=2 --log=true ./ -- -config-file="$TELEPRESENCE_ROOT/etc/todo-app/redis.config"
```

Use the folowwing `launch` configuration (VS Code) to attach debugger:

```json
...
{
  "name": "Telepresence",
  "type": "go",
  "request": "launch",
  "mode": "remote",
  "apiVersion": 2,
  "remotePath": "${workspaceFolder}/",
  "port": 2345,
  "host": "127.0.0.1",
  "program": "${workspaceFolder}/",
  "env": {}
}
...
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
