FROM ubuntu:22.04

# 패키지 업데이트
RUN apt-get update

# 기본 도구 설치
RUN apt-get install -y curl

# 테스트용 메시지
RUN echo "Hello from Ubuntu container!" > /message.txt

# 컨테이너 실행 시 출력
CMD ["cat", "/message.txt"]
