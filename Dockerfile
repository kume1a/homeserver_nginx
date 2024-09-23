FROM nginx:latest

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

RUN echo "172.17.0.1 host.docker.internal" >> /etc/hosts

CMD /bin/sh -c 'nginx -g "daemon off;"'
