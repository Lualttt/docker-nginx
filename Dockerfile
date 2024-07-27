FROM debian

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y wget libpcre3-dev build-essential libssl-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/refs/tags/v1.2.2-r1.tar.gz -O "nginx-rtmp-module.tar.gz" && \
    tar -zxvf nginx-rtmp-module.tar.gz && \
    mv nginx-rtmp-module-* nginx-rtmp-module

RUN wget http://nginx.org/download/nginx-1.23.1.tar.gz && \
    tar -zxvf nginx-1.*.tar.gz && \
    cd nginx-1.* && \
    ./configure --prefix=/opt/nginx --user=nginx --group=nginx --with-http_ssl_module --with-ipv6 --with-threads --with-stream --with-stream_ssl_module --with-stream_ssl_preread_module --add-module=../nginx-rtmp-module && \
    make && make install && \
    cd .. && rm -rf nginx-1.* && \
    rm -rf nginx-rtmp*

# nginx user
RUN adduser --system --no-create-home --disabled-login --disabled-password --group nginx

# config dirs
RUN mkdir /opt/nginx/http.conf.d && mkdir /opt/nginx/stream.conf.d && mkdir /opt/nginx/rtmp.conf.d

RUN mkdir /var/www
RUN mkdir /var/www/livestream
ADD stat.xsl /var/www/livestream/stat.xsl

ADD nginx.conf /opt/nginx/conf/nginx.conf
ADD zero_downtime_reload.sh /opt/nginx/sbin/zero_downtime_reload.sh

WORKDIR /

EXPOSE 80 443

CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]
