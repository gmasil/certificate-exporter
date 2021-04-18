FROM alpine

RUN apk add --no-cache nmap-ncat openssl coreutils

ADD check-certs.sh /check-certs.sh
ADD header.sh /header.sh

EXPOSE 80

CMD nc -lk -p 80 -e /header.sh /check-certs.sh
