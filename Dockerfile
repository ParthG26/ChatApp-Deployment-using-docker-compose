#-----------------Stage 1: Builder--------------

FROM ubuntu:latest AS builder

RUN apt-get update && apt-get install -y gnupg ca-certificates

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y \
    git \
    curl \
    gcc \
    python3.8 \
    python3.8-venv \
    python3.8-dev \
    python3-pip \
    build-essential \
    python3.8-distutils \
    default-libmysqlclient-dev \
    pkg-config \
    mysql-client

WORKDIR /chat_app
RUN git clone https://github.com/ParthG26/ChatApp-Application-Deployment.git .

#------------------Stage 2: Runtime---------------

FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    python3.8 \
    python3-pip \
    ca-certificates \
    mysql-client

WORKDIR /chat_app

COPY --from=builder /chat_app /chat_app

RUN python3.8 -m venv venv && \
    bash -c "source venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt && pip install gunicorn mysqlclient python-dotenv"

COPY .env /chat_app/.env

WORKDIR /chat_app/fundoo

EXPOSE 8000

CMD ["/bin/bash", "-c", "set -a && source /chat_app/.env && set +a && source /chat_app/venv/bin/activate && python3 /chat_app/manage.py migrate && /chat_app/venv/bin/gunicorn --bind 0.0.0.0:8000 fundoo.wsgi:application"]