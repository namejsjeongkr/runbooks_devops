# 개요
* ArgoCD 설치

# 설치 방법

```sh
kubectl kustomize ./ | kubectl apply -f -
```

# 설치 확인

* pod가 전부 Running 상태이어야 함

```sh
kubectl get pod,svc -n argocd
❯ kubectl get pod,svc -n argocd
NAME                                                   READY   STATUS    RESTARTS   AGE
pod/argocd-application-controller-0                    1/1     Running   0          88s
pod/argocd-applicationset-controller-5f975ff5-45ccs    1/1     Running   0          88s
pod/argocd-dex-server-7bb445db59-qkxl4                 1/1     Running   0          88s
pod/argocd-notifications-controller-566465df76-kd5vt   1/1     Running   0          88s
pod/argocd-redis-6976fc7dfc-89jlt                      1/1     Running   0          88s
pod/argocd-repo-server-6d8d59bbc7-v8wts                1/1     Running   0          88s
pod/argocd-server-58f5668765-n4n8m                     1/1     Running   0          88s

NAME                                              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
service/argocd-applicationset-controller          ClusterIP   10.96.25.23     <none>        7000/TCP,8080/TCP            89s
service/argocd-dex-server                         ClusterIP   10.96.216.148   <none>        5556/TCP,5557/TCP,5558/TCP   89s
service/argocd-metrics                            ClusterIP   10.96.34.219    <none>        8082/TCP                     88s
service/argocd-notifications-controller-metrics   ClusterIP   10.96.36.145    <none>        9001/TCP                     88s
service/argocd-redis                              ClusterIP   10.96.204.139   <none>        6379/TCP                     88s
service/argocd-repo-server                        ClusterIP   10.96.183.39    <none>        8081/TCP,8084/TCP            88s
service/argocd-server                             NodePort    10.96.76.116    <none>        80:30960/TCP,443:30961/TCP   88s
service/argocd-server-metrics                     ClusterIP   10.96.206.244   <none>        8083/TCP                     88s
```

# ArgoCD 접속 방법

* 웹 브라우저에서 https://127.0.0.1:30961 로 접속

* 로그인
  * 아이디: admin
  * 비밀번호: kubectl로 확인

```sh
# 비밀번호 확인
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

# 삭제 방법

```sh
kubectl kustomize ./ | kubectl delete -f -
```
