FROM mysql:5.7

RUN apt update 
RUN apt-get -y install zlib1g-dev uuid-dev libmnl-dev gcc make git autoconf autogen automake pkg-config curl jq nodejs
RUN apt-get -y install bash curl
RUN curl -s https://packagecloud.io/install/repositories/netdata/netdata/script.deb.sh |  bash
RUN apt -y install netdata 
RUN apt -y install vim wget

RUN apt-get install -y procps python3-dev default-libmysqlclient-dev build-essential
RUN apt-get install -y python3-pip
RUN pip3 install mysqlclient
RUN sed -i "s#localhost#0.0.0.0#g" /etc/netdata/netdata.conf 


ADD mysql-netdata-entrypoint.sh /usr/local/bin/mysql-netdata-entrypoint.sh
RUN chmod +x /usr/local/bin/mysql-netdata-entrypoint.sh
RUN ln -s usr/local/bin/mysql-netdata-entrypoint.sh /mysql-netdata-entrypoint.sh

EXPOSE 19999
ENTRYPOINT [ "mysql-netdata-entrypoint.sh" ]
CMD [ "mysqld" ]


