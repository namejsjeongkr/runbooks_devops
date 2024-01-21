# 개요
* ArgoRollout 설치

# 설치방법

```sh
./install.sh
```

# 확인

```sh
$ kubectl get pod,svc,ingress -n argo-rollouts
NAME                                                        READY   STATUS    RESTARTS   AGE
pod/argo-rollout-argo-rollouts-748df66bf8-25qt2             1/1     Running   0          8m55s
pod/argo-rollout-argo-rollouts-748df66bf8-rl6jx             1/1     Running   0          8m55s
pod/argo-rollout-argo-rollouts-dashboard-7df546cfdc-kpm2p   1/1     Running   0          8m55s

NAME                                           TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/argo-rollout-argo-rollouts-dashboard   ClusterIP   10.96.121.31   <none>        3100/TCP   8m55s

NAME                                              CLASS   HOSTS   ADDRESS   PORTS   AGE
ingress.networking.k8s.io/argo-rollouts-ingress   nginx   *                 80      4s
```

# ingress 설정

```sh
sudo vi /etc/hosts
127.0.0.1 argo-rollout.localhost.com
```
