FROM nginx:latest

# 웹 페이지 파일을 컨테이너에 복사
COPY ./html /usr/share/nginx/html

# 포트 노출
EXPOSE 80

# Nginx 실행
CMD ["nginx", "-g", "daemon off;"]