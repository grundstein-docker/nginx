# wizardsatwork/grundstein/openresty dockerfile
# VERSION 0.0.1

FROM alpine:3.3

MAINTAINER Wizards & Witches <dev@wiznwit.com>
ENV REFRESHED_AT 2016-21-02

ARG TARGET_DIR
ARG VERSION
ARG PORT_80
ARG PORT_443

# Build Nginx from source
RUN apk --update add openssl-dev pcre-dev zlib-dev build-base curl

RUN curl -Ls http://nginx.org/download/nginx-${VERSION}.tar.gz | tar -xz -C /tmp && \
    cd /tmp/nginx-${VERSION} && \
    ./configure \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --prefix=${TARGET_DIR} \
        --conf-path=/etc/nginx/nginx.conf \
        --http-log-path=/var/log/nginx/access.log \
        --error-log-path=/var/log/nginx/error.log \
        --pid-path=/var/run/nginx.pid \
        --sbin-path=/usr/sbin/nginx && \
        --with-mail \
    make && \
    make install

RUN apk del build-base && \
    mkdir -p /etc/nginx/conf.d && \
    rm -rf /tmp/*

RUN echo -ne "- with `nginx -v 2>&1`\n" >> /root/.built

# Add Nginx default config
COPY etc /etc

# add sources
COPY ./src ${TARGET_DIR}

# add log directory and pipe it to stdout
RUN mkdir -p ${TARGET_DIR}/logs \
  && ln -sf /dev/stdout ${TARGET_DIR}/logs/access.log

# Expose ports
EXPOSE ${PORT_80} ${PORT_443}

WORKDIR ${TARGET_DIR}

CMD ["nginx", "-g", "daemon off;"]
