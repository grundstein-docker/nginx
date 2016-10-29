# grundstein/nginx dockerfile
# VERSION 0.0.1

FROM alpine:3.4

MAINTAINER Wizards & Witches <dev@wiznwit.com>
ENV REFRESHED_AT 2016-29-10

ARG TARGET_DIR
ARG VERSION

# Build Nginx from source
RUN apk --update add openssl-dev pcre-dev zlib-dev build-base curl

# download and build nginx
RUN curl -Ls http://nginx.org/download/nginx-${VERSION}.tar.gz | tar -xz -C /tmp && \
    cd /tmp/nginx-${VERSION} && \
    ./configure \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --prefix=${TARGET_DIR} \
        --conf-path=${TARGET_DIR}/conf/nginx.conf \
        --http-log-path=${TARGET_DIR}/logs/access.log \
        --error-log-path=${TARGET_DIR}/logs/error.log \
        --pid-path=${TARGET_DIR}/nginx.pid \
        --sbin-path=/usr/sbin/nginx &&\
    make && \
    make install

#cleanup
RUN apk del build-base && \
    rm -rf /tmp/*

RUN echo -ne "- with `nginx -v 2>&1`\n" >> /root/.built

# add sources
COPY ./out ${TARGET_DIR}/conf/

ARG PORT_80
ARG PORT_443

# Expose ports
EXPOSE ${PORT_80} ${PORT_443}

WORKDIR ${TARGET_DIR}

CMD ["nginx", "-g", "daemon off;"]
