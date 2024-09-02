FROM nginx:latest

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD /bin/sh -c 'echo "172.17.0.1 host.docker.internal" >> /etc/hosts && nginx -g "daemon off;"'
