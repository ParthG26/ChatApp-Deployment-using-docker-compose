FROM ubuntu:latest

RUN apt update && apt install nginx -y

COPY template/nginx.conf /etc/nginx/sites-available/default

EXPOSE 80

CMD ["nginx","-g", "daemon off;"]