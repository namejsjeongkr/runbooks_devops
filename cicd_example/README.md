- [전제조건](#전제조건)
- [ECR 로그인](#ecr-로그인)
- [도커 이미지 생성](#도커-이미지-생성)
- [도커 컨테이너 실행](#도커-컨테이너-실행)
- [ECR에 도커 이미지 push](#ecr에-도커-이미지-push)
- [EKS 배포](#eks-배포)
- [오류 해결](#오류-해결)

# 전제조건
* assume IAM role 필요

# ECR 로그인

```sh
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 467606240901.dkr.ecr.ap-northeast-2.amazonaws.com
```

# 도커 이미지 생성

```sh
# 자기 이름
MY_TAG="sungwook_v1"
sudo docker build -t 467606240901.dkr.ecr.ap-northeast-2.amazonaws.com/education:${MY_TAG} .
```

# 도커 컨테이너 실행
* 도커 컨테이너 실행

```sh
MY_TAG="sungwook_v1"
docker run --rm --name python-test -p 8000:8000 -d 467606240901.dkr.ecr.ap-northeast-2.amazonaws.com/education:${MY_TAG}
```

* 호출 테스트

```sh
$ curl 127.0.0.1:8000
{"Hello":"World"}
```

* 도커 컨테이너 삭제

```sh
docker kill python-test
```

# ECR에 도커 이미지 push

```sh
MY_TAG="sungwook_v1"
docker push 467606240901.dkr.ecr.ap-northeast-2.amazonaws.com/education:${MY_TAG}

The push refers to repository [467606240901.dkr.ecr.ap-northeast-2.amazonaws.com/education]
7f6f1544f9b3: Pushed
5f70bf18a086: Pushed
bd65e63340af: Pushed
1a87a3133e2a: Pushed
2096a0be7465: Pushed
d6c86f26e1da: Pushing [==================================================>]  35.83MB
a6e608b01535: Pushing [==================================================>]   9.43MB
6f2d01c02c30: Pushing [===============================>                   ]   61.9MB/97.11MB
```

# EKS 배포

* namespace를 자기 이름으로 수정
```sh
$ cd manifests
$ vi deployment.yaml
$ vi ingress.yaml
$ vi service.yaml

namespace: yaml
```

* 배포 확인

```sh
kubectl get pod -n {자기 이름}
NAME                               READY   STATUS             RESTARTS        AGE
python-ecr-test-5b4486969f-fwcml   0/1     CrashLoopBackOff   6 (2m31s ago)   8m5s
```

* pod 로그 확인

```sh
$ kubectl logs -f {pod 이름} -n {자기 이름}
exec /usr/local/bin/uvicorn: exec format error
```

# 오류 해결

```sh
# 멀티 플랫폼 준비
docker buildx create --name multiarch-builder --use
docker buildx inspect --bootstrap


MY_TAG="sungwook_v2"
docker push 467606240901.dkr.ecr.ap-northeast-2.amazonaws.com/education:${MY_TAG}
```

* 멀티 플랫폼 도커 이미지 생성 & push

```sh
# 도커 이미지 태그 버전 업
MY_TAG="sungwook_v2"
sudo docker buildx build --push --platform linux/arm64/v8,linux/amd64 -t 467606240901.dkr.ecr.ap-northeast-2.amazonaws.com/education:${MY_TAG} .
```

* deployment.yaml에서 도커 이미지 태그 수정
```sh
$ cd manifests
$ vi deployment.yaml
```

* deployment.yaml 배포

```yaml
$ cd manifests
$ kubectl apply -f deployment.yaml
```

* 오류 수정 확인

```sh
$ kubectl get pod -n sungwook
NAME                               READY   STATUS    RESTARTS   AGE
python-ecr-test-77dd4b89cd-cm7v5   1/1     Running   0          40m

$ kubectl logs {pod 이름} -n {자기 이름}
INFO:     Started server process [1]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
```
