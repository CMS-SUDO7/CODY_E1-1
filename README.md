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
<img width="1516" height="648" alt="터미널 조작 로그" src="https://github.com/user-attachments/assets/cbca955a-dddb-4f9b-bb14-39ce241491a0" />
5. 🔐 권한 실습
<img width="1152" height="648" alt="권한변경 실습" src="https://github.com/user-attachments/assets/5985b2ef-cce8-4b0f-9b25-079c0621679a" />
6. 🐳 Docker 설치 및 점검
<img width="1508" height="808" alt="docker 설치 및 점검" src="https://github.com/user-attachments/assets/c37a57e2-5777-4f12-8664-14df75ac3247" />
7. 🐳 Docker 기본 운용 명령 실행
<img width="1541" height="881" alt="docker 기본 운영 명령 실행" src="https://github.com/user-attachments/assets/042e0510-1915-470e-9724-8ba3274ffc38" />
8. 🐳 컨테이너 실습 (Ubuntu)
<img width="1541" height="881" alt="hello world 와 docker ubuntu" src="https://github.com/user-attachments/assets/3f1a1df0-de48-40ac-b8f4-5f5603293112" />

## attach vs exec 차이

## attach

docker attach 컨테이너ID

특징

기존 컨테이너의 표준 입력/출력에 직접 연결

원래 실행 중이던 프로세스에 붙음

exit 하면 컨테이너 종료될 수 있음

## exec

docker exec -it 컨테이너ID bash

특징

새로운 쉘을 추가로 실행

기존 컨테이너는 계속 살아 있음

안전하게 작업 가능

| 항목     | attach     | exec   |
| ------ | ---------- | ------ |
| 연결 방식  | 기존 프로세스    | 새 프로세스 |
| exit 시 | 컨테이너 종료 가능 | 종료 안됨  |
| 사용 목적  | 디버깅        | 작업/관리  |

9. 🏗️ 커스텀 이미지 제작

✔️ 베이스 이미지

nginx

✔️ 커스터마이징 목적

정적 웹 페이지 제공

index.html 변경
<img width="1541" height="881" alt="dockerfile 커스텀 이미지1" src="https://github.com/user-attachments/assets/4ad4730c-db21-4134-a2c1-3e78ddfd2201" />
<img width="1541" height="881" alt="dockerfile 커스텀 이미지2" src="https://github.com/user-attachments/assets/593515ac-d9c2-4e2c-9dc0-627a925e2e1b" />
nginx 이미지를 기반으로 커스텀 이미지를 제작하였다.

기존 웹 서버 환경을 활용하여 정적 콘텐츠만 변경하는 방식을 선택하였다.

index.html 파일을 수정하여 사용자 정의 웹 페이지 생성

nginx 기본 페이지를 커스텀 페이지로 대체

<img width="1541" height="881" alt="커스텀 이미지 변경 전 후" src="https://github.com/user-attachments/assets/3140b74e-7be3-4433-bfe8-a5b7e66ff9a9" />

10. 🌐 포트 매핑 및 접속
<img width="1541" height="881" alt="포트매핑 접속증거2" src="https://github.com/user-attachments/assets/2561ff71-8ca3-4b87-bb25-5424b72b48ff" />
<img width="1541" height="881" alt="포트매핑 접속증거" src="https://github.com/user-attachments/assets/2dffe772-58b5-4645-9da7-8bc54cdf9cc0" 
  
11. 🔗 바인드 마운트 검증
<img width="1541" height="881" alt="바인드 마운트 결과" src="https://github.com/user-attachments/assets/dfe6bf28-3468-4b01-a987-b8b7468ac6d2" />

12. 💾 Docker 볼륨 영속성 검증
docker volume create my-volume

docker run -d -v my-volume:/data --name vol-test ubuntu

docker exec vol-test bash -c "echo hello > /data/test.txt"

docker rm -f vol-test

docker run -d -v my-volume:/data --name vol-test2 ubuntu

docker exec vol-test2 cat /data/test.txt
✔️ 결과
컨테이너 삭제 후에도 데이터 유지 확인
<img width="1541" height="881" alt="증명docker 볼륨 및 영속성 검" src="https://github.com/user-attachments/assets/167b18c9-27ff-472d-a04a-b9d6bf9f18a0" />

13. 🔧 Git 설정 및 GitHub 연동
git config --global user.name "your-name"
git config --global user.email "your-email"
git config --list
✔️ 결과
사용자 정보 설정 확인 완료
git init
git add .
git commit -m "init project"
git branch -M main
git remote add origin <repo-url>
git push -u origin main
