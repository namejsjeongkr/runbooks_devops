# 개요
* EKS ALB 테스트

# 전제조건
* AWS IAM assume

# 실습

* namespace 생성

```sh
# 다른 사람과 겹치지 않게 쿠버네티스 namespace를 생성

$ kubectl create ns sungwook # your name
$ kubectl get ns sungwook
```

* manifest의 namespace 수정

```sh
$ cat pod.yaml

namespace: { your name }

$ cat service.yaml

namespace: { your name }

$ cat ingress.yaml

namespace: { your name }
```

* ingress 도메인 수정

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: https
  namespace: your-name
  ...
spec:
  ingressClassName: alb
  rules:
  - host: {your-name}-alb.choilab.xyz
```

# 배포

```sh
kubectl apply -f ./
```

# 확인

```sh
kubectl get pod,svc,ingress -n {your-name}

NAME            READY   STATUS    RESTARTS   AGE
pod/pod-https   1/1     Running   0          3m50s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   172.20.0.1      <none>        443/TCP    28h
service/svc-https    ClusterIP   172.20.202.23   <none>        8080/TCP   3m50s

NAME                              CLASS   HOSTS                      ADDRESS                                                                    PORTS   AGE
ingress.networking.k8s.io/https   alb     sungwook-alb.choilab.xyz   k8s-default-https-726eeaf222-1574624698.ap-northeast-2.elb.amazonaws.com   80      2m19s
```

# 도메인 전파 확인 및 curl 요청(또는 웹브라우저)

```sh
$ dig +short {your-name}-alb.choilab.xyz
43.200.119.245
$ curl https://{your-name}-alb.choilab.xyz
Hostname: pod-https

Pod Information:
        -no pod information available-

Server values:
        server_version=nginx: 1.13.1 - lua: 10008

Request Information:
        client_address=10.0.10.16
        method=GET
        real path=/
        query=
        request_version=1.1
        request_uri=http://sungwook-alb.choilab.xyz:8080/

Request Headers:
        accept=*/*
        host=sungwook-alb.choilab.xyz
        user-agent=curl/7.88.1
        x-amzn-trace-id=Root=1-65aff229-09c912ba1f8e21f537a1aad4
        x-forwarded-for=39.114.235.189
        x-forwarded-port=443
        x-forwarded-proto=https

Request Body:
        -no body in request-
```