# grundstein/nginx dockerfile
# VERSION 0.0.1

FROM alpine:3.4

MAINTAINER Wizards & Witches <dev@wiznwit.com>
ENV REFRESHED_AT 18-11-2016

ENV VERSION 1.10.1
ENV WORKDIR /home/nginx

# Build Nginx from source
RUN apk --update add openssl-dev pcre-dev zlib-dev build-base curl

# download and build nginx
RUN curl -Ls http://nginx.org/download/nginx-${VERSION}.tar.gz | tar -xz -C /tmp && \
    cd /tmp/nginx-${VERSION} && \
    ./configure \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --prefix=${WORKDIR} \
        --conf-path=${WORKDIR}/conf/nginx.conf \
        --http-log-path=${WORKDIR}/logs/access.log \
        --error-log-path=${WORKDIR}/logs/error.log \
        --pid-path=${WORKDIR}/nginx.pid \
        --sbin-path=/usr/sbin/nginx &&\
    make && \
    make install

#cleanup
RUN apk del build-base && \
    rm -rf /tmp/*

RUN echo -ne "- with `nginx -v 2>&1`\n" >> /root/.built

# add config
COPY ./conf/ ${WORKDIR}/conf/

COPY entrypoint.sh ${WORKDIR}/entrypoint.sh
RUN chmod +x ${WORKDIR}/entrypoint.sh

WORKDIR ${WORKDIR}

ENTRYPOINT ${WORKDIR}/entrypoint.sh

CMD ["nginx", "-g", "daemon off;"]
