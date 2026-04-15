🚀 개발 워크스테이션 구축 프로젝트
# 프로젝트 개요

본 프로젝트는 Docker와 Git을 활용하여 개발 워크스테이션 환경을 구축하고,
컨테이너 기반 웹 서버 실행 및 운영을 검증하는 것을 목표로 한다.

또한 터미널 명령어, 파일 권한, Docker 운영, GitHub 연동까지
개발 환경의 전반적인 흐름을 실습하고 검증한다.

## 1) 실행 환경
- OS: Ubuntu 22.04
- Shell: bash
- Docker: 26.x
- Git: 2.x

## 2) 수행 체크리스트
- [x] 터미널 기본 조작 및 폴더 구성
- [x] 권한 변경 실습
- [x] Docker 설치/점검
- [x] hello-world 실행
- [x] Dockerfile 빌드/실행
- [x] 포트 매핑 접속(2회)
- [x] 바인드 마운트 반영
- [x] 볼륨 영속성
- [x] Git 설정 + VSCode GitHub 연동

4. 💻 터미널 조작 로그

herebattle6145@c5r9s1 CODY_E1-1 % pwd 

/Users/herebattle6145/CODY_E1-1

herebattle6145@c5r9s1 CODY_E1-1 % ls -la

total 24
drwxr-xr-x   5 herebattle6145  herebattle6145   160 Apr 15 18:41 .

drwxr-x---+ 24 herebattle6145  herebattle6145   768 Apr 15 18:50 ..

drwxr-xr-x  13 herebattle6145  herebattle6145   416 Apr 15 18:41 .git

drwxr-xr-x   3 herebattle6145  herebattle6145    96 Apr 15 18:34 practice

-rw-r--r--   1 herebattle6145  herebattle6145  9867 Apr 15 18:32 README.md

herebattle6145@c5r9s1 CODY_E1-1 % touch test.txt

herebattle6145@c5r9s1 CODY_E1-1 % mkdir test

herebattle6145@c5r9s1 CODY_E1-1 % cp test.txt copy.txt

herebattle6145@c5r9s1 CODY_E1-1 % mv copy.txt move.txt

herebattle6145@c5r9s1 CODY_E1-1 % rm move.txt

herebattle6145@c5r9s1 CODY_E1-1 % cat test.txt

<img width="1262" height="397" alt="Screenshot 2026-04-15 at 6 55 24 PM" src="https://github.com/user-attachments/assets/f5fb901f-24da-4af1-a8e9-93bdb98448aa" />

5. 🔐 권한 실습

herebattle6145@c5r9s1 CODY_E1-1 % ls -l test.txt

-rw-r--r--  1 herebattle6145  herebattle6145  0 Apr 15 18:59 test.txt

herebattle6145@c5r9s1 CODY_E1-1 % chmod 777 test.txt

herebattle6145@c5r9s1 CODY_E1-1 % ls -l test.txt

-rwxrwxrwx  1 herebattle6145  herebattle6145  0 Apr 15 18:59 test.txt

<img width="1235" height="126" alt="Screenshot 2026-04-15 at 7 00 48 PM" src="https://github.com/user-attachments/assets/4b8ef1ba-b17d-45e4-90cf-de6dad8aea47" />

6. 🐳 Docker 설치 및 점검

herebattle6145@c5r9s1 CODY_E1-1 % docker version

<img width="1243" height="691" alt="Screenshot 2026-04-15 at 7 03 23 PM" src="https://github.com/user-attachments/assets/061441e1-2e5f-4c79-9db3-08ced8d759cc" />


herebattle6145@c5r9s1 CODY_E1-1 % docker info

<img width="1537" height="750" alt="Screenshot 2026-04-15 at 7 07 54 PM" src="https://github.com/user-attachments/assets/845744c1-784b-48b4-b906-f4558e44f264" />


7. 🐳 Docker 기본 운용 명령 실행

docker pull hello-worldhello-world

docker run hello-world

<img width="1261" height="286" alt="Screenshot 2026-04-15 at 8 15 01 PM" src="https://github.com/user-attachments/assets/9989165d-90be-45f1-9f9c-b4cf803a0387" />


docker images

docker ps

docker ps -a

<img width="1272" height="273" alt="Screenshot 2026-04-15 at 8 15 39 PM" src="https://github.com/user-attachments/assets/cb4a9751-edfb-488c-92fc-0973ea92726c" />

dockerfile로 build 실행+결과

docker build -t ubuntu2 .

docker run ubuntu2

<img width="1269" height="420" alt="Screenshot 2026-04-15 at 9 36 41 PM" src="https://github.com/user-attachments/assets/7e02aaa4-7767-4201-9692-7676c4f6cc6c" />



8. 🐳 컨테이너 실습 (Ubuntu)

docker run -it ubuntu

echo "Hello"

ls

exit

<img width="1264" height="193" alt="Screenshot 2026-04-15 at 9 20 15 PM" src="https://github.com/user-attachments/assets/f2d6721c-cc4d-4091-949c-0264abf2807a" />


9. 🏗️ 커스텀 이미지 제작


10. 🌐 포트 매핑 및 접속

docker run -d -p 8080:80 nginx



  
11. 🔗 바인드 마운트 검증

herebattle6145@c5r9s1 CODY_E1-1 % mkdir bind-test

herebattle6145@c5r9s1 CODY_E1-1 % cd bind-test

herebattle6145@c5r9s1 bind-test % echo "hello" >test.txt

erebattle6145@c5r9s1 bind-test %  docker run -it -v $(pwd):/app ubuntu bash 

root@fd0c47a6789d:/# ls /app

test.txt

root@fd0c47a6789d:/# cat /app/test.txt

hello

root@fd0c47a6789d:/# echo "hello from container" > /app/test.txt

root@fd0c47a6789d:/# exit

exit

herebattle6145@c5r9s1 bind-test % cat test.txt

hello from container

<img width="1276" height="79" alt="Screenshot 2026-04-15 at 9 52 00 PM" src="https://github.com/user-attachments/assets/88eaa317-5744-4dc1-8cc8-e6f19da86bc4" />


<img width="1275" height="247" alt="Screenshot 2026-04-15 at 9 52 51 PM" src="https://github.com/user-attachments/assets/c4ca3419-5bba-4963-8aeb-2db94e3499f0" />


12. 💾 Docker 볼륨 영속성 검증

<img width="1276" height="225" alt="Screenshot 2026-04-15 at 10 05 16 PM" src="https://github.com/user-attachments/assets/46c51d79-ba7f-498b-9628-2ba6a17b23ec" />


<img width="1286" height="269" alt="Screenshot 2026-04-15 at 10 04 43 PM" src="https://github.com/user-attachments/assets/7c2e1351-7c83-4f17-8ca0-b0e1be7e7023" />


✔️ 결과
컨테이너 삭제 후에도 데이터 유지 확인


13. 🔧 Git 설정 및 GitHub 연동

git config --global user.name "CMS-SUDO7"

git config --global user.email "herebattle@naver.com"

git config --global init.defaultBranch main

git config --list

git init

git add .

git commit -m "first commit"

https://github.com/CMS-SUDO7/my-nginx.git

git remote add origin https://github.com/CMS-SUDo7/my-nginx.git

git push -u origin main

<img width="1541" height="881" alt="github 연동" src="https://github.com/user-attachments/assets/ecbcddfe-44db-46ff-bfb6-03578cd14586" />

### ⚠️트러블슈팅 (커스텀 이미지 적용 실패 문제)

#### 1. 문제

커스텀 Docker 이미지를 기반으로 컨테이너를 실행한 후
http://localhost:8080 에 접속하였으나,
사용자가 작성한 HTML 페이지가 아닌 기본 "Welcome to nginx" 화면이 출력되었다.

---

#### 2. 원인 가설

해당 문제는 다음과 같은 원인으로 발생했을 가능성이 있다고 판단하였다.

* 기존에 실행 중이던 nginx 컨테이너가 동일한 포트(8080)를 점유하고 있을 가능성
* 커스텀 이미지가 아닌 기본 nginx 이미지가 실행되었을 가능성
* Dockerfile 변경 사항이 이미지에 반영되지 않았을 가능성

---

#### 3. 확인 과정

1. 실행 중인 컨테이너 확인

```bash
docker ps
```

→ 확인 결과, 기존 nginx 이미지 기반 컨테이너가 실행 중이며 8080 포트를 사용 중임을 확인하였다.

---

2. 이미지 목록 확인

```bash
docker images
```

→ my-nginx 이미지가 정상적으로 생성되어 있음을 확인하였다.

---

#### 4. 해결 및 대안

1. 기존 컨테이너 종료

```bash
docker stop [컨테이너 ID]
```

→ 기존 nginx 컨테이너를 종료하여 포트 충돌 문제를 해결하였다.

---

2. 커스텀 이미지 기반 컨테이너 재실행

```bash
docker run -d -p 8080:80 my-nginx
```

→ 이후 브라우저 접속 시 사용자 정의 HTML 페이지가 정상 출력됨을 확인하였다.

---

3. 대안 방법

* 포트 충돌을 피하기 위해 다른 포트를 사용하는 방법

```bash
docker run -d -p 8081:80 my-nginx
```

* 캐시 문제를 방지하기 위해 이미지 재빌드

```bash
docker build -t my-nginx . --no-cache
```

---

#### 5. 결론

본 문제는 기존 컨테이너의 포트 점유로 인해 발생한 것으로 확인되었으며,
컨테이너 관리 및 포트 사용 상태 확인의 중요성을 이해할 수 있었다.

### ⚠️트러블슈팅 (GitHub 인증 오류 해결)

#### 문제  
git push 수행 시 "Password authentication is not supported" 오류 발생

#### 원인 가설  
GitHub에서 보안 정책 변경으로 인해 비밀번호 인증이 차단된 것으로 판단

#### 확인  
오류 메시지를 통해 토큰 기반 인증 필요함을 확인

#### 해결  
GitHub에서 Personal Access Token을 생성한 후,
비밀번호 입력 대신 토큰을 사용하여 인증을 수행

#### 결론  
GitHub는 보안 강화를 위해 비밀번호 대신 토큰 기반 인증을 사용함을 확인하였다.


⚠️ 트러블슈팅 (WSL chmod 문제)
❗ 문제

chmod 600 test.txt

ls -l

명령을 실행했지만 파일 권한이 바뀌지 않고 계속 -rwxrwxrwx 상태로 나타남

🔍 원인 가설

파일이 위치한 경로 /mnt/c/...는 Windows 파일 시스템(NTFS)

NTFS는 Linux 방식의 chmod 권한을 완전히 지원하지 않음

따라서 chmod 명령이 실행되어도 실제 권한에 반영되지 않음

✅ 확인

/mnt/c/... 경로에서 chmod 적용 시 권한 변화 없음 확인

ls -l test.txt

# 출력: -rwxrwxrwx

Linux 홈 디렉토리(~/perm-test)로 이동 후 재실습

mkdir ~/perm-test

cd ~/perm-test

touch file.txt

chmod 600 file.txt

ls -l file.txt

# 출력: -rw-------

Linux 경로에서는 chmod가 정상적으로 반영됨

🛠️ 해결 / 대안

권장 해결: 실습 파일을 Linux 파일 시스템 영역(예: /home)으로 이동 후 chmod 적용

고급 대안: WSL 설정 변경 (/etc/wsl.conf에서 metadata 옵션 활성화) 후 재시작

주의: Windows 경로(/mnt/c)에서는 chmod 권한 변경이 제한적이므로, 권한 실습은 항상 Linux 경로에서 수행
