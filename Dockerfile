FROM klakegg/hugo as builder
EXPOSE 80
EXPOSE 443

ADD . /src
WORKDIR /src
RUN hugo -D


FROM nginx

COPY --from=builder /src/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /src/nginx/expires.inc /etc/nginx/conf.d/expires.inc
RUN chmod 0644 /etc/nginx/conf.d/expires.inc
RUN sed -i '9i\        include /etc/nginx/conf.d/expires.inc;\n' /etc/nginx/conf.d/default.conf

COPY --from=builder /src/public /var/www/io.alexheld.site/
COPY --from=builder /src/static /var/www/io.alexheld.site/static
