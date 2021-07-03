FROM klakegg/hugo as builder

EXPOSE 80
EXPOSE 443

ADD . /src
WORKDIR /src
RUN hugo -D --minify


FROM nginx
COPY --from=builder /src/public /usr/share/nginx/html
COPY --from=builder /src/nginx.conf /etc/nginx/nginx.conf