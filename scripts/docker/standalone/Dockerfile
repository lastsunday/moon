FROM mariadb:10.5.8-focal

RUN apt-get update && apt-get install -y \
    openjdk-8-jre \
    redis-server \
    supervisor \
    sudo
    
RUN mkdir -p /var/run/redis-server /var/run/mariadb /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord"]

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./app/ /usr/local/app/workspace/
WORKDIR /usr/local/app/workspace/

EXPOSE 9211
