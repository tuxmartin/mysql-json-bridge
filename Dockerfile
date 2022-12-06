# syntax=docker/dockerfile:1
FROM python:2.7.15-alpine3.6
LABEL maintainer="https://www.vancl-it.cz/"

WORKDIR /usr/src/app

COPY config/ ./
COPY tornado/ ./
COPY app.py ./
COPY app.py ./
COPY renovate.json ./
COPY requirements.txt ./

EXPOSE 5000

RUN <<EOT
  mkdir conf.d
  apk --no-cache add --virtual build-dependencies build-base py-mysqldb gcc libc-dev libffi-dev mariadb-dev
  pip install --upgrade pip
  pip install -qq -r requirements.txt
  rm -rf .cache/pip \
  apk del build-dependencies
EOT

CMD [ "python2", "./app.py", ">>", "/proc/1/fd/1" ]
