# kind cluster 설치

```sh
kind create cluster --config config.yaml
```

# kind cluster 설치 확인

```sh
kubectl cluster-info --context kind-kind-demo
```

# nginx ingress controller 설치

```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

# ingress example
* [kind nginx ingress 예제](../../k8s_default_object/ingress.yaml)

# kind cluster 삭제 방법

```sh
kind delete cluster --name kind-demo
```
