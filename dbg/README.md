# How to guide

## Patch K8s deployment

Patch K8s `todo-app` deployment with `debug` image and expose DEBUG port.

```sh
k patch deploy/todo-app --type="json" --patch "$(/bin/cat dbg/patch-debug.json)" -ntodo-app
```

## Restore original deployment

```sh
k patch deploy/todo-app --type="merge" --patch "$(/bin/cat k8s-deployment/todo-app-deployment.yaml)" -ntodo-app
```