FROM ubuntu:latest

RUN apt update && apt install mysql-server -y

RUN service mysql start && \
    mysql -u root -p"chatapp_admin" -e "CREATE DATABASE IF NOT EXISTS ChatApp;" && \
    mysql -u root -p"chatapp_admin" -e "CREATE USER IF NOT EXISTS 'chat_user'@'%' IDENTIFIED BY 'chatapp_admin';" && \
    mysql -u root -p"chatapp_admin" -e "GRANT ALL PRIVILEGES ON ChatApp.* TO chat_user@'%';" && \
    mysql -u root -p"chatapp_admin" -e "FLUSH PRIVILEGES;" && \
    service mysql stop && \
    service mysql start

EXPOSE 3306

CMD ["/usr/sbin/mysqld", "--bind-address=0.0.0.0"]
