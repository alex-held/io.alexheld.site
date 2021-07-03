FROM klakegg/hugo:alpine as builder
EXPOSE 80
EXPOSE 443

COPY . /app
WORKDIR /app/src
RUN hugo -D -d /app/public

FROM nginx
LABEL maintainer="dev@alexheld.io"

COPY --from=builder /app/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/nginx/expires.inc /etc/nginx/conf.d/expires.inc
RUN chmod 0644 /etc/nginx/conf.d/expires.inc
RUN sed -i '9i\        include /etc/nginx/conf.d/expires.inc;\n' /etc/nginx/conf.d/default.conf

COPY --from=builder /app/public /var/www/site/
COPY --from=builder /app/src/static /var/www/site/static
