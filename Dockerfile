FROM alpine:3.6

RUN apk add --update-cache nginx nginx-mod-stream py-pip bash curl

RUN pip install j2cli

ADD nginx.conf.j2 /nginx.conf.j2
ADD nginx-site.conf.j2 /nginx-site.conf.j2
ADD entrypoint.sh /entrypoint.sh
ADD self-test.sh /self-test.sh

RUN chmod +x /entrypoint.sh /self-test.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
