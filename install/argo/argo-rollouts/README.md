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

# kind 클러스터에서 ingress 설정

```sh
sudo vi /etc/hosts
127.0.0.1 argo-rollout.localhost.com
```

# bluegreen 실습 예제(EKS환경)

```sh
# 1. namespace 생성
kubectl create ns {yourname}

# 2. rollout-bluegreen.yaml에서 ingress host를 수정

# EKS에서만 실행되는 ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: rollout-demo
  namespace: sungwook
spec:
  ingressClassName: alb
  rules:
    - host: rollout-demo.choilab.xyz # change me rollout-{yourname}.choilab.xyz

# 3. 생성
kubectl -n {yourname} apply -f rollout-bluegreen.yaml

# 4. 도메인 접속(약 5분 뒤)
```