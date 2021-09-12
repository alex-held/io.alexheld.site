FROM klakegg/hugo:alpine as build

WORKDIR /src
COPY src /src
RUN hugo -D -d /app/site
RUN mv static /app/site/static
RUN ls -R -1 /app

ADD nginx/nginx.conf /etc/nginx/nginx.conf
RUN ls -R -1 /etc/nginx

FROM nginx
LABEL maintainer="dev@alexheld.io"
COPY --from=build /etc/nginx /etc/nginx
COPY --from=build /app/site /var/www/site
RUN ls  -R -1  /etc/nginx
RUN ls  -R -1 /var/www/site
