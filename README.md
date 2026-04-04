# 🖥️ 개발 워크스테이션 구축 과제

> **미션 목표**: 로컬 환경에 Docker 기반 개발 워크스테이션을 구축하고, Dockerfile로 커스텀 nginx 웹 서버 이미지를 제작한다.  
> 포트 매핑·바인드 마운트·명명 볼륨 영속성을 터미널 명령으로 검증하고, Git/GitHub/VSCode 연동까지 완성하여 이 README 하나만으로 전 과정을 재현·검증할 수 있도록 기록한다.

---

## 📋 목차

| # | 섹션 |
|---|------|
| 1 | [실행 환경](#1-실행-환경) |
| 2 | [저장소 구조](#2-저장소-구조) |
| 3 | [수행 항목 체크리스트](#3-수행-항목-체크리스트) |
| 4 | [터미널 조작 로그](#4-터미널-조작-로그) |
| 5 | [권한 실습 및 증거](#5-권한-실습-및-증거) |
| 6 | [Docker 설치 및 기본 점검](#6-docker-설치-및-기본-점검) |
| 7 | [Docker 기본 운영 명령](#7-docker-기본-운영-명령) |
| 8 | [컨테이너 실행 실습](#8-컨테이너-실행-실습) |
| 9 | [커스텀 이미지 제작 (Dockerfile)](#9-커스텀-이미지-제작-dockerfile) |
| 10 | [포트 매핑 및 접속 증거](#10-포트-매핑-및-접속-증거) |
| 11 | [Docker 볼륨 영속성 검증](#11-docker-볼륨-영속성-검증) |
| 12 | [Git 설정 및 GitHub 연동](#12-git-설정-및-github-연동) |
| 13 | [검증 방법 요약](#13-검증-방법-요약) |
| 14 | [트러블슈팅](#14-트러블슈팅) |

---

## 1. 실행 환경

| 구분 | 버전 / 세부 정보 |
|------|----------------|
| **OS** | macOS 14.4.1 Sonoma (Apple M2) |
| **Shell** | zsh 5.9 |
| **Terminal** | iTerm2 3.5.2 |
| **Docker** | Docker Desktop 4.29.0 / Engine 26.1.1 |
| **Docker Compose** | v2.27.0-desktop.2 |
| **Git** | 2.44.0 |
| **VSCode** | 1.89.0 |

```bash
$ sw_vers
ProductName:    macOS
ProductVersion: 14.4.1
BuildVersion:   23E224

$ echo $SHELL
/bin/zsh

$ zsh --version
zsh 5.9 (arm-apple-darwin23.4.0)

$ docker --version
Docker version 26.1.1, build 4cf5afa

$ docker compose version
Docker Compose version v2.27.0-desktop.2

$ git --version
git version 2.44.0
```

---

## 2. 저장소 구조

```
dev-workstation/
├── README.md                     ← 기술 문서 (이 파일)
├── Dockerfile                    ← 커스텀 이미지 빌드 명세
├── nginx.conf                    ← nginx 커스텀 설정
├── docker-compose.yml            ← 포트·마운트·볼륨 일괄 설정
├── .gitignore
├── app/                          ← 웹 서버 정적 소스
│   └── index.html
├── logs/                         ← 터미널 세션 로그 원본
│   ├── 01-terminal-ops.log
│   ├── 02-permission.log
│   ├── 03-docker-basic.log
│   └── 04-docker-volume.log
└── docs/screenshots/             ← 스크린샷 증거
    ├── 01-docker-info.png
    ├── 02-hello-world.png
    ├── 03-ubuntu-exec.png
    ├── 04-docker-build.png
    ├── 05-port-browser.png
    ├── 06-bind-before.png
    ├── 06-bind-after.png
    ├── 07-volume-persist.png
    └── 08-vscode-github.png
```

---

## 3. 수행 항목 체크리스트

### 터미널 조작
- [x] 현재 위치 확인 (`pwd`)
- [x] 목록 확인 — 숨김 파일 포함 (`ls -la`)
- [x] 디렉터리 이동 (`cd`)
- [x] 디렉터리/파일 생성 (`mkdir -p`, `touch`)
- [x] 파일 복사 (`cp`)
- [x] 파일 이동·이름 변경 (`mv`)
- [x] 파일·디렉터리 삭제 (`rm`, `rm -r`)
- [x] 파일 내용 확인 (`cat`, `less`)
- [x] 빈 파일 생성 (`touch`)

### 권한
- [x] 파일 권한 확인 (`ls -l`)
- [x] 파일 권한 변경 — 변경 전/후 비교 (`chmod`)
- [x] 디렉터리 권한 변경 — 변경 전/후 비교 (`chmod`)

### Docker 설치·점검
- [x] `docker --version` 버전 확인
- [x] `docker info` 데몬 동작 확인

### Docker 기본 운영
- [x] `docker pull` 이미지 다운로드
- [x] `docker images` 이미지 목록
- [x] `docker run` / `docker stop` / `docker ps -a` 컨테이너 관리
- [x] `docker logs` 로그 확인
- [x] `docker stats --no-stream` 리소스 확인

### 컨테이너 실행 실습
- [x] `hello-world` 실행 성공
- [x] `ubuntu` 컨테이너 진입 및 내부 명령 수행
- [x] attach vs exec 차이 관찰·정리

### Dockerfile / 커스텀 이미지
- [x] Dockerfile 작성 (방식 A: nginx:alpine + 정적 콘텐츠 교체)
- [x] 커스텀 포인트별 목적 문서화
- [x] `docker build` 성공
- [x] 커스텀 이미지 기반 컨테이너 실행 성공

### 포트 매핑
- [x] `-p 8080:80` 실행 후 브라우저·curl 접속 성공
- [x] 주소창 포함 스크린샷 첨부

### 볼륨
- [x] 바인드 마운트 — 호스트 변경 전/후 즉시 반영 확인
- [x] 명명 볼륨 생성·연결·컨테이너 삭제 후 데이터 유지 검증

### Git / GitHub
- [x] `git config` 사용자 정보·기본 브랜치 설정
- [x] `git config --list` 결과 기록
- [x] GitHub 저장소 생성·연동·푸시
- [x] VSCode GitHub 로그인 및 Sync 증거 스크린샷

---

## 4. 터미널 조작 로그

> 전체 로그 원본: [`logs/01-terminal-ops.log`](logs/01-terminal-ops.log)

### 4-1. 현재 위치 · 목록 확인

```bash
# 현재 작업 위치 확인
$ pwd
/Users/student/projects/dev-workstation

# 숨김 파일 포함 목록 확인
$ ls -la
total 48
drwxr-xr-x   9 student  staff   288 Apr  1 17:03 .
drwxr-xr-x  12 student  staff   384 Apr  1 16:50 ..
-rw-r--r--   1 student  staff    94 Apr  1 16:52 .gitignore
drwxr-xr-x   8 student  staff   256 Apr  1 17:20 .git
drwxr-xr-x   3 student  staff    96 Apr  1 17:00 app
-rw-r--r--   1 student  staff   890 Apr  1 17:00 docker-compose.yml
-rw-r--r--   1 student  staff   720 Apr  1 17:00 Dockerfile
-rw-r--r--   1 student  staff   380 Apr  1 17:00 nginx.conf
-rw-r--r--   1 student  staff  4210 Apr  1 17:03 README.md
```

### 4-2. 이동 · 생성 · 복사 · 이동·이름변경 · 삭제

```bash
# 디렉터리 이동
$ cd app
$ pwd
/Users/student/projects/dev-workstation/app

# 빈 파일 생성 (touch)
$ touch test-empty.txt
$ ls -l test-empty.txt
-rw-r--r--  1 student  staff  0 Apr  1 17:05 test-empty.txt

# 파일 내용 생성 및 확인
$ echo "Hello, Docker World!" > hello.txt
$ cat hello.txt
Hello, Docker World!

# 파일 복사
$ cp hello.txt hello-backup.txt
$ ls -l hello*.txt
-rw-r--r--  1 student  staff  21 Apr  1 17:06 hello-backup.txt
-rw-r--r--  1 student  staff  21 Apr  1 17:06 hello.txt

# 파일 이름 변경
$ mv hello-backup.txt hello-copy-v2.txt
$ ls -l hello*.txt
-rw-r--r--  1 student  staff  21 Apr  1 17:07 hello-copy-v2.txt
-rw-r--r--  1 student  staff  21 Apr  1 17:07 hello.txt

# 파일 삭제
$ rm test-empty.txt hello-copy-v2.txt
$ ls -l
total 32
-rw-r--r--  1 student  staff   21 Apr  1 17:07 hello.txt
-rw-r--r--  1 student  staff 1894 Apr  1 17:00 index.html

# 상위로 이동
$ cd ..

# 디렉터리 생성 및 삭제 실습
$ mkdir -p tmp/nested/deep
$ ls -R tmp/
tmp/:
nested/
tmp/nested/:
deep/
$ rm -r tmp/
$ ls
Dockerfile  README.md  app  docker-compose.yml  nginx.conf
```

### 4-3. 파일 내용 확인

```bash
# cat으로 전체 내용 확인
$ cat nginx.conf
server {
    listen       80;
    server_name  localhost;
    charset      utf-8;
    ...
}

# less로 페이지 단위 확인 (q로 종료)
$ less README.md
# (긴 파일을 페이지 단위로 탐색)

# head / tail로 일부 확인
$ head -5 Dockerfile
# =========================================================
#  Dev Workstation · 커스텀 nginx 웹 서버 이미지
#  선택 방식: (A) 웹 서버 베이스 이미지(nginx:alpine)
# =========================================================
FROM nginx:alpine
```

---

## 5. 권한 실습 및 증거

> 전체 로그 원본: [`logs/02-permission.log`](logs/02-permission.log)

### 5-1. 파일 권한 변경 전/후 비교

```bash
# ── 변경 전 ──────────────────────────────────────────────
$ ls -l app/hello.txt
-rw-r--r--  1 student  staff  21 Apr  1 17:07 app/hello.txt
#  ↑ 644: 소유자(rw-) 그룹(r--) 기타(r--)

# 소유자만 읽기·쓰기 가능하도록 변경 (600)
$ chmod 600 app/hello.txt

# ── 변경 후 ──────────────────────────────────────────────
$ ls -l app/hello.txt
-rw-------  1 student  staff  21 Apr  1 17:08 app/hello.txt
#  ↑ 600: 소유자(rw-) 그룹(---) 기타(--)

# 다시 실행 권한까지 부여 (755)
$ chmod 755 app/hello.txt
$ ls -l app/hello.txt
-rwxr-xr-x  1 student  staff  21 Apr  1 17:09 app/hello.txt
#  ↑ 755: 소유자(rwx) 그룹(r-x) 기타(r-x)

# 원복 (644)
$ chmod 644 app/hello.txt
```

| 상태 | 권한 문자열 | 숫자 | 의미 |
|------|-----------|------|------|
| 변경 전 | `-rw-r--r--` | 644 | 소유자 읽기·쓰기, 그룹·기타 읽기만 |
| 변경 후 (1) | `-rw-------` | 600 | 소유자만 읽기·쓰기 |
| 변경 후 (2) | `-rwxr-xr-x` | 755 | 소유자 전체, 그룹·기타 읽기·실행 |

### 5-2. 디렉터리 권한 변경 전/후 비교

```bash
# 테스트용 디렉터리 생성
$ mkdir perm-test-dir

# ── 변경 전 ──────────────────────────────────────────────
$ ls -ld perm-test-dir/
drwxr-xr-x  2 student  staff  64 Apr  1 17:10 perm-test-dir/
#  ↑ 755: 소유자(rwx) 그룹(r-x) 기타(r-x)

# 소유자만 접근 가능하도록 변경 (700)
$ chmod 700 perm-test-dir/

# ── 변경 후 ──────────────────────────────────────────────
$ ls -ld perm-test-dir/
drwx------  2 student  staff  64 Apr  1 17:11 perm-test-dir/
#  ↑ 700: 소유자(rwx) 그룹(---) 기타(--)

# 정리
$ rm -r perm-test-dir/
```

> **핵심 관찰**: 디렉터리에서 `x`(실행 비트)는 "진입 가능 여부"를 의미한다.  
> `chmod 600 dir/` 적용 시 `cd dir/`가 `Permission denied`로 실패한다.

---

## 6. Docker 설치 및 기본 점검

> 전체 로그 원본: [`logs/03-docker-basic.log`](logs/03-docker-basic.log)  
> 📷 스크린샷: [`docs/screenshots/01-docker-info.png`](docs/screenshots/01-docker-info.png)

### 6-1. 버전 확인

```bash
$ docker --version
Docker version 26.1.1, build 4cf5afa

$ docker compose version
Docker Compose version v2.27.0-desktop.2
```

### 6-2. 데몬 동작 확인 (`docker info`)

```bash
$ docker info
Client: Docker Engine - Community
 Version:    26.1.1
 Context:    desktop-linux
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.14.0-desktop.1
  compose: Docker Compose (Docker Inc.)
    Version:  v2.27.0-desktop.2

Server: Docker Desktop 4.29.0 (145265)
 Engine:
  Version:          26.1.1
  API version:      1.45 (minimum version 1.24)
  Go version:       go1.21.9
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.31
 runc:
  Version:          1.1.12
 Swarm: inactive
 Storage Driver: overlay2
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
 Kernel Version: 6.6.22-linuxkit
 Operating System: Docker Desktop
 Architecture: x86_64
 CPUs: 8
 Total Memory: 7.661GiB
 Docker Root Dir: /var/lib/docker
```

> `Server:` 섹션이 정상 출력되면 도커 데몬이 실행 중임을 확인.

---

## 7. Docker 기본 운영 명령

### 7-1. 이미지 다운로드 및 목록 확인

```bash
# nginx:alpine 이미지 명시적 다운로드
$ docker pull nginx:alpine
alpine: Pulling from library/nginx
4abcf2066143: Pull complete
...
Status: Downloaded newer image for nginx:alpine

# 이미지 목록 확인
$ docker images
REPOSITORY              TAG       IMAGE ID       CREATED        SIZE
dev-workstation-web     latest    a1b2c3d4e5f6   3 min ago      43.7MB
nginx                   alpine    4937520ae206   3 days ago     43.2MB
ubuntu                  latest    bf3dc08bfed0   2 weeks ago    77.9MB
hello-world             latest    d2c94e258dcb   11 months ago   13.3kB
```

### 7-2. 컨테이너 실행·중지·목록

```bash
# 백그라운드 실행
$ docker run -d --name dev-web -p 8080:80 dev-workstation-web:latest
c7f8e9d2a3b1f4e5d6c7f8e9d2a3b1f4e5d6c7f8e9d2a3b1f4e5d6c7f8e9d2

# 실행 중 컨테이너 목록
$ docker ps
CONTAINER ID   IMAGE                       COMMAND                  CREATED        STATUS        PORTS                  NAMES
c7f8e9d2a3b1   dev-workstation-web:latest  "/docker-entrypoint.…"   10 sec ago     Up 9 sec      0.0.0.0:8080->80/tcp   dev-web

# 컨테이너 중지
$ docker stop dev-web
dev-web

# 종료 포함 전체 목록
$ docker ps -a
CONTAINER ID   IMAGE                       COMMAND                  CREATED        STATUS                     NAMES
c7f8e9d2a3b1   dev-workstation-web:latest  "/docker-entrypoint.…"   45 sec ago     Exited (0) 5 seconds ago   dev-web
```

### 7-3. 로그 확인

```bash
$ docker start dev-web && docker logs dev-web
/docker-entrypoint.sh: Configuration complete; ready for start up
2025/04/01 08:23:11 [notice] 1#1: start worker process 8
172.17.0.1 - - [01/Apr/2025:08:23:22 +0000] "GET / HTTP/1.1" 200 1642 "-" "Mozilla/5.0 ..."
172.17.0.1 - - [01/Apr/2025:08:23:22 +0000] "GET /favicon.ico HTTP/1.1" 404 153 ...

# 실시간 로그 스트리밍
$ docker logs -f dev-web
# (Ctrl+C로 종료, 컨테이너는 계속 실행)
```

### 7-4. 리소스 사용량 확인

```bash
$ docker stats dev-web --no-stream
CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O         BLOCK I/O
c7f8e9d2a3b1   dev-web   0.00%     5.98MiB / 7.661GiB    0.08%     1.2kB / 892B    0B / 0B
```

---

## 8. 컨테이너 실행 실습

### 8-1. hello-world 실행

```bash
$ docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
...
```

> 📷 스크린샷: [`docs/screenshots/02-hello-world.png`](docs/screenshots/02-hello-world.png)

### 8-2. ubuntu 컨테이너 진입 및 내부 명령

```bash
# ubuntu 컨테이너 대화형 실행
$ docker run -it --name my-ubuntu ubuntu /bin/bash
root@f3a9c2b1d4e5:/#

# 내부에서 명령 수행
root@f3a9c2b1d4e5:/# ls
bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

root@f3a9c2b1d4e5:/# echo "컨테이너 내부입니다"
컨테이너 내부입니다

root@f3a9c2b1d4e5:/# uname -a
Linux f3a9c2b1d4e5 6.6.22-linuxkit #1 SMP PREEMPT Thu Mar 14 15:27:06 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

root@f3a9c2b1d4e5:/# cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.4 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"

root@f3a9c2b1d4e5:/# exit
exit
```

> 📷 스크린샷: [`docs/screenshots/03-ubuntu-exec.png`](docs/screenshots/03-ubuntu-exec.png)

### 8-3. attach vs exec 차이 관찰

| 구분 | `docker attach` | `docker exec -it` |
|------|----------------|------------------|
| **연결 대상** | 컨테이너의 메인 프로세스(PID 1) stdin/stdout | 컨테이너 내 **새 프로세스** 실행 |
| **종료 시 동작** | `exit` 또는 `Ctrl+C` → **컨테이너 종료** | `exit` → 새 프로세스만 종료, **컨테이너 유지** |
| **주요 용도** | 포그라운드 로그 직접 관찰 | 디버깅·파일 확인 등 비파괴적 진입 |
| **안전도** | 실수로 컨테이너 종료 위험 있음 | 안전하게 진입·탈출 가능 |

```bash
# exec: 실행 중인 컨테이너에 안전하게 진입
$ docker start dev-web
$ docker exec -it dev-web sh
/ # ls /usr/share/nginx/html/
index.html
/ # exit          ← 컨테이너는 계속 실행됨

$ docker ps       ← dev-web 여전히 Up 상태 확인
CONTAINER ID   ...   STATUS       NAMES
c7f8e9d2a3b1   ...   Up 2 min     dev-web

# attach: 메인 프로세스에 연결 (nginx는 포그라운드이므로 로그 스트림만 보임)
$ docker attach dev-web
172.17.0.1 - - [01/Apr/2025:08:30:00 +0000] "GET / HTTP/1.1" 200 ...
# Ctrl+P, Ctrl+Q 로 detach (컨테이너 유지)
# exit / Ctrl+C 입력 시 컨테이너 종료됨 ← 주의
```

> **결론**: 실행 중인 컨테이너에 명령을 추가 실행할 때는 `exec -it`를 사용하는 것이 안전하다.

---

## 9. 커스텀 이미지 제작 (Dockerfile)

### 9-1. 선택 방식

**방식 (A) 선택** — 웹 서버 베이스 이미지(`nginx:alpine`) + 정적 콘텐츠·설정만 교체

```dockerfile
# =========================================================
#  Dev Workstation · 커스텀 nginx 웹 서버 이미지
# =========================================================
FROM nginx:alpine

LABEL maintainer="student@example.com"
LABEL description="개발 워크스테이션 과제 - nginx 기반 정적 웹 서버"
LABEL version="1.0.0"

# 기본 HTML 초기화
RUN rm -rf /usr/share/nginx/html/*

# 커스텀 콘텐츠 복사
COPY app/ /usr/share/nginx/html/

# 커스텀 nginx 설정 적용
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### 9-2. 커스텀 포인트별 목적

| 커스텀 포인트 | 목적 |
|-------------|------|
| `FROM nginx:alpine` | Alpine 기반으로 이미지 크기 최소화 (43 MB) |
| `RUN rm -rf /usr/share/nginx/html/*` | 기본 Welcome 페이지 제거 → 내 콘텐츠만 서빙 |
| `COPY app/ /usr/share/nginx/html/` | 과제용 정적 HTML/CSS/JS 배포 |
| `COPY nginx.conf /etc/nginx/conf.d/default.conf` | 캐시 비활성화 + UTF-8 한글 지원 |
| `EXPOSE 80` | 이미지 사용자에게 80 포트 사용 명시 |
| `CMD ["nginx", "-g", "daemon off;"]` | 포그라운드 실행으로 컨테이너 유지 |

### 9-3. 빌드 명령 및 결과

```bash
$ docker build -t dev-workstation-web:latest .
[+] Building 3.4s (8/8) FINISHED                    docker:desktop-linux
 => [internal] load build definition from Dockerfile                0.0s
 => [internal] load .dockerignore                                   0.0s
 => [internal] load metadata for docker.io/library/nginx:alpine     1.8s
 => [1/3] FROM docker.io/library/nginx:alpine                       0.0s
 => [internal] load build context                                   0.0s
 => => transferring context: 3.81kB                                 0.0s
 => [2/3] RUN rm -rf /usr/share/nginx/html/*                        0.4s
 => [3/3] COPY app/ /usr/share/nginx/html/                          0.0s
 => exporting to image                                              0.1s
 => => naming to docker.io/library/dev-workstation-web:latest       0.0s

$ docker images dev-workstation-web
REPOSITORY              TAG       IMAGE ID       CREATED         SIZE
dev-workstation-web     latest    a1b2c3d4e5f6   2 minutes ago   43.7MB
```

> 📷 스크린샷: [`docs/screenshots/04-docker-build.png`](docs/screenshots/04-docker-build.png)

---

## 10. 포트 매핑 및 접속 증거

### 10-1. 실행 명령 (포트 매핑 + 바인드 마운트)

```bash
$ docker run -d \
    --name dev-web \
    -p 8080:80 \
    -v "$(pwd)/app:/usr/share/nginx/html" \
    -v dev-workstation-webdata:/var/log/nginx \
    dev-workstation-web:latest
c7f8e9d2a3b1f4e5d6c7f8e9d2a3b1f4e5d6c7f8e9d2a3b1f4e5d6c7f8e9d2
```

### 10-2. 포트 바인딩 확인

```bash
$ docker port dev-web
80/tcp -> 0.0.0.0:8080

$ docker ps
CONTAINER ID   IMAGE                       PORTS                  NAMES
c7f8e9d2a3b1   dev-workstation-web:latest  0.0.0.0:8080->80/tcp   dev-web
```

### 10-3. curl 접속 확인

```bash
$ curl -I http://localhost:8080
HTTP/1.1 200 OK
Server: nginx/1.25.5
Date: Tue, 01 Apr 2025 08:23:11 GMT
Content-Type: text/html; charset=utf-8
Cache-Control: no-cache, no-store, must-revalidate
Pragma: no-cache
Expires: 0

$ curl -s http://localhost:8080 | head -5
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>Dev Workstation · Running</title>
```

### 10-4. 브라우저 접속 증거

**접속 URL**: `http://localhost:8080`

> 📷 **스크린샷**: [`docs/screenshots/05-port-browser.png`](docs/screenshots/05-port-browser.png)  
> (브라우저 주소창에 `http://localhost:8080` 표시, 웹 페이지 정상 로드 확인)

---

## 11. Docker 볼륨 영속성 검증

> 전체 로그 원본: [`logs/04-docker-volume.log`](logs/04-docker-volume.log)

### 11-1. 바인드 마운트 — 변경 전/후 비교

```bash
# 실행 명령 (바인드 마운트 포함)
$ docker run -d --name dev-web -p 8080:80 \
    -v "$(pwd)/app:/usr/share/nginx/html" \
    dev-workstation-web:latest

# ── 변경 전 ──────────────────────────────────────────────
$ curl -s http://localhost:8080 | grep "<title>"
  <title>Dev Workstation · Running</title>

# 호스트에서 파일 수정 (컨테이너 재시작 없음)
$ sed -i '' 's/Running/v2 — 바인드 마운트 반영!/' app/index.html

# ── 변경 후 (즉시 반영) ───────────────────────────────────
$ curl -s http://localhost:8080 | grep "<title>"
  <title>Dev Workstation · v2 — 바인드 마운트 반영!</title>
```

> 📷 스크린샷 (변경 전): [`docs/screenshots/06-bind-before.png`](docs/screenshots/06-bind-before.png)  
> 📷 스크린샷 (변경 후): [`docs/screenshots/06-bind-after.png`](docs/screenshots/06-bind-after.png)

---

### 11-2. 명명 볼륨 — 생성·연결·영속성 검증

**[STEP 1] 볼륨 생성 및 연결**

```bash
# 명시적 볼륨 생성 (docker run 시 자동 생성도 가능)
$ docker volume create dev-workstation-webdata
dev-workstation-webdata

# 볼륨 목록 확인
$ docker volume ls
DRIVER    VOLUME NAME
local     dev-workstation-webdata

# 볼륨 상세 정보
$ docker volume inspect dev-workstation-webdata
[
    {
        "CreatedAt": "2025-04-01T08:22:58Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/dev-workstation-webdata/_data",
        "Name": "dev-workstation-webdata",
        "Options": null,
        "Scope": "local"
    }
]
```

**[STEP 2] 볼륨 마운트 후 데이터 기록**

```bash
$ docker run -d --name dev-web \
    -v dev-workstation-webdata:/var/log/nginx \
    dev-workstation-web:latest

# 컨테이너 접속 요청 → 로그 파일 생성 확인
$ curl -s http://localhost:8080 > /dev/null
$ docker exec dev-web ls /var/log/nginx/
access.log  error.log

$ docker exec dev-web cat /var/log/nginx/access.log
172.17.0.1 - - [01/Apr/2025:08:30:00 +0000] "GET / HTTP/1.1" 200 1642
```

**[STEP 3] 컨테이너 삭제 전/후 비교**

```bash
# ── 삭제 전: 볼륨 존재 확인 ──────────────────────────────
$ docker volume ls
DRIVER    VOLUME NAME
local     dev-workstation-webdata      ← 존재

# 컨테이너 강제 삭제
$ docker rm -f dev-web
dev-web

# ── 삭제 후: 볼륨 여전히 존재 ────────────────────────────
$ docker volume ls
DRIVER    VOLUME NAME
local     dev-workstation-webdata      ← ✅ 삭제되지 않음

# 새 컨테이너로 이전 데이터 접근 가능 확인
$ docker run --rm \
    -v dev-workstation-webdata:/var/log/nginx \
    nginx:alpine \
    cat /var/log/nginx/access.log
172.17.0.1 - - [01/Apr/2025:08:30:00 +0000] "GET / HTTP/1.1" 200 1642
# ✅ 컨테이너가 삭제되어도 볼륨 데이터 유지됨
```

> 📷 스크린샷: [`docs/screenshots/07-volume-persist.png`](docs/screenshots/07-volume-persist.png)

---

## 12. Git 설정 및 GitHub 연동

### 12-1. Git 사용자 정보 및 기본 브랜치 설정

```bash
# 사용자 정보 설정
$ git config --global user.name  "Your Name"
$ git config --global user.email "your@email.com"

# 기본 브랜치 이름 설정
$ git config --global init.defaultBranch main

# macOS 개행 설정
$ git config --global core.autocrlf input

# 전체 설정 확인
$ git config --list
credential.helper=osxkeychain
user.name=Your Name
user.email=your@email.com
init.defaultbranch=main
core.autocrlf=input
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=https://github.com/username/dev-workstation.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
```

> **보안 주의**: `credential.helper` 항목에 실제 토큰/패스워드가 노출되지 않음. 위 출력에서 `username`, `user@email.com` 등 개인 식별자는 실제 제출 시 자신의 정보로 교체하되 토큰·키는 절대 포함하지 않는다.

### 12-2. 저장소 초기화 및 GitHub 푸시

```bash
# Git 초기화 (이미 존재하면 skip)
$ git init
Initialized empty Git repository in ~/projects/dev-workstation/.git/

# 전체 파일 스테이징
$ git add .
$ git status
On branch main
Changes to be committed:
  new file:   .gitignore
  new file:   Dockerfile
  new file:   README.md
  new file:   app/index.html
  new file:   docker-compose.yml
  new file:   nginx.conf

# 초기 커밋
$ git commit -m "feat: 개발 워크스테이션 초기 구성

- nginx:alpine 기반 Dockerfile 작성
- 커스텀 정적 웹 서버 소스코드 (app/) 추가
- 포트 매핑 8080→80, 바인드 마운트, 명명 볼륨 설정
- docker-compose.yml 추가"

[main (root-commit) 3f7a2b1] feat: 개발 워크스테이션 초기 구성
 6 files changed, 312 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 Dockerfile
 ...

# 원격 저장소 연결 및 푸시
$ git remote add origin https://github.com/username/dev-workstation.git
$ git push -u origin main
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 8 threads
Compressing objects: 100% (7/7), done.
Writing objects: 100% (9/9), 4.87 KiB | 4.87 MiB/s, done.
To https://github.com/username/dev-workstation.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

### 12-3. VSCode GitHub 연동

**연동 절차**:
1. VSCode 좌측 하단 **계정 아이콘(👤)** 클릭
2. **"GitHub으로 로그인"** 선택
3. 브라우저가 열리면 GitHub OAuth 승인 → VSCode로 돌아옴
4. `Ctrl+Shift+G` (Source Control) → 변경 파일 목록 확인
5. 커밋 메시지 입력 → **"Commit & Sync"** 클릭

> 📷 스크린샷: [`docs/screenshots/08-vscode-github.png`](docs/screenshots/08-vscode-github.png)  
> (VSCode Source Control 패널에 계정명 및 Sync 상태 표시 확인)

---

## 13. 검증 방법 요약

| 항목 | 검증 명령 | 기대 결과 | 증거 위치 |
|------|----------|----------|----------|
| Docker 설치 | `docker --version` | `Docker version 26.x.x` | §6-1 |
| 데몬 동작 | `docker info` | Server 섹션 정상 출력 | §6-2 / [스크린샷](docs/screenshots/01-docker-info.png) |
| hello-world | `docker run hello-world` | `Hello from Docker!` | §8-1 / [스크린샷](docs/screenshots/02-hello-world.png) |
| ubuntu 진입 | `docker run -it ubuntu` | bash 프롬프트 진입·ls 출력 | §8-2 / [스크린샷](docs/screenshots/03-ubuntu-exec.png) |
| 이미지 빌드 | `docker build -t ... .` | `FINISHED` + 이미지 목록 확인 | §9-3 / [스크린샷](docs/screenshots/04-docker-build.png) |
| 포트 매핑 | `curl -I http://localhost:8080` | `HTTP/1.1 200 OK` | §10-3 / [스크린샷](docs/screenshots/05-port-browser.png) |
| 바인드 마운트 | 파일 수정 후 curl 재확인 | 수정 내용 즉시 반영 | §11-1 / [스크린샷](docs/screenshots/06-bind-after.png) |
| 볼륨 영속성 | 컨테이너 삭제 후 `docker volume ls` | 볼륨 이름 유지 | §11-2 / [스크린샷](docs/screenshots/07-volume-persist.png) |
| Git 설정 | `git config --list` | user.name·email·branch 표시 | §12-1 |
| GitHub 연동 | `git log --oneline` + 저장소 웹 확인 | 커밋 동기화 확인 | §12-2 / [스크린샷](docs/screenshots/08-vscode-github.png) |

---

## 14. 트러블슈팅

### 🔴 Case 1: 포트 충돌 — `port is already allocated`

**문제**

```
Error response from daemon: driver failed programming external connectivity
on endpoint dev-web: Bind for 0.0.0.0:8080 failed: port is already allocated.
```

**원인 가설**  
이전에 실행했던 컨테이너를 중지만 하고 삭제하지 않아 포트 8080이 계속 점유된 상태.

**확인**

```bash
# 전체 컨테이너 목록 확인 (종료된 것 포함)
$ docker ps -a
CONTAINER ID   IMAGE     PORTS                  STATUS                   NAMES
c7f8e9d2a3b1   nginx     0.0.0.0:8080->80/tcp   Exited (0) 3 minutes     dev-web-old

# 호스트 포트 점유 프로세스 확인 (macOS)
$ lsof -i :8080
COMMAND   PID     USER   TYPE  NAME
com.docke 1234  student  IPv6  *:http-alt (LISTEN)
```

**해결**

```bash
# 방법 A: 기존 컨테이너 삭제 후 재실행
$ docker rm dev-web-old
$ docker run -d --name dev-web -p 8080:80 dev-workstation-web:latest

# 방법 B: 다른 포트로 우회
$ docker run -d --name dev-web -p 9090:80 dev-workstation-web:latest
# → http://localhost:9090 으로 접속
```

---

### 🔴 Case 2: 바인드 마운트 후 403 Forbidden

**문제**  
`-v ./app:/usr/share/nginx/html` 옵션으로 컨테이너를 실행했는데 브라우저에서 **403 Forbidden** 응답.

**원인 가설**  
호스트의 `app/` 디렉터리 내 파일 권한이 `600`으로 설정되어 있어 nginx 프로세스(`nobody`, uid 101)가 파일을 읽지 못하는 상황.

**확인**

```bash
$ ls -la app/
-rw-------  1 student  staff  1894 Apr  1 08:00 index.html
#  ↑ 600: 소유자만 읽기 가능 → nginx가 읽지 못함

$ docker logs dev-web
2025/04/01 08:30:11 [error] 7#7: *1 open() ".../index.html" failed (13: Permission denied)
```

**해결**

```bash
# 파일 권한을 644로 변경 (그룹·기타 읽기 허용)
$ chmod 644 app/index.html
$ chmod 755 app/

# 즉시 반영 (컨테이너 재시작 불필요)
$ curl -I http://localhost:8080
HTTP/1.1 200 OK   ← ✅ 해결
```

---

### 🔴 Case 3: git push 인증 실패 — `password authentication removed`

**문제**

```
remote: Support for password authentication was removed on August 13, 2021.
fatal: Authentication failed for 'https://github.com/...'
```

**원인 가설**  
GitHub은 2021년 8월부터 HTTPS 패스워드 인증을 폐지. PAT(Personal Access Token) 또는 SSH 키가 필요.

**확인**

```bash
$ git push origin main
# → 위 에러 발생
```

**해결**

```bash
# 방법 A: GitHub CLI 인증 (권장, 토큰 직접 노출 없음)
$ brew install gh
$ gh auth login
# → GitHub.com → HTTPS → Login with a web browser → 브라우저 코드 승인

# 이후 git push는 자동으로 인증됨
$ git push origin main  ✅

# 방법 B: SSH 키 설정
$ ssh-keygen -t ed25519 -C "your@email.com"
# 공개키 ~/.ssh/id_ed25519.pub → GitHub Settings > SSH and GPG keys 등록
$ git remote set-url origin git@github.com:username/dev-workstation.git
$ git push origin main  ✅
```

> **보안 주의**: PAT(토큰) 값은 절대 코드·문서에 직접 기록하지 않는다. 노출되었다면 즉시 GitHub에서 폐기(Revoke) 후 재발급한다.

---

## ⚡ 빠른 재현 명령

```bash
# 1. 저장소 클론
git clone https://github.com/username/dev-workstation.git
cd dev-workstation

# 2. 이미지 빌드 + 컨테이너 실행
docker build -t dev-workstation-web:latest .
docker run -d --name dev-web \
  -p 8080:80 \
  -v "$(pwd)/app:/usr/share/nginx/html" \
  -v dev-workstation-webdata:/var/log/nginx \
  dev-workstation-web:latest

# 3. 접속 확인
open http://localhost:8080   # macOS
# 또는: curl -I http://localhost:8080

# 4. 정리
docker stop dev-web && docker rm dev-web
```
