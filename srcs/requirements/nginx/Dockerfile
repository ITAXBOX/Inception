FROM alpine:3.22

EXPOSE 443

ARG DOMAIN_NAME
ARG CERTS
# install nginx and openssl
# openssl to create a self-signed certificate
RUN apk update && apk upgrade && apk add --no-cache nginx openssl sed

RUN mkdir -p $CERTS
# create a self-signed certificate
# the certificate is valid for 365 days
# the subject fields are filled with example data
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout $CERTS/nginx.key \
	-out $CERTS/nginx.crt \
	-subj "/C=LB/ST=Beirut/L=Beirut/O=42Beirut/CN=${DOMAIN_NAME}"

COPY conf/nginx.conf /etc/nginx/nginx.conf
# replace DOMAIN_NAME and CERTS in nginx.conf with the actual values
RUN sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/nginx.conf \
&&  sed -i "s%CERTS%$CERTS%g" /etc/nginx/nginx.conf
# nginx should run in the foreground, -g means global directives and daemon off; means do not daemonize
CMD ["nginx", "-g", "daemon off;"]