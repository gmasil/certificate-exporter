FROM debian

RUN apt update \
    && apt upgrade -y \
    && apt install locales netcat openssl -y

# openbsd

# set locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD check-certs.sh /check-certs.sh
ADD header.sh /header.sh

EXPOSE 80

CMD while true ; do nc -l -p 80 -c '/header.sh /check-certs.sh' ; done
