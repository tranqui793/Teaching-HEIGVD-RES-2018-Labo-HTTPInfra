FROM node:8

MAINTAINER Adam Zouari <adam.zouari@heig-vd.ch>
MAINTAINER Oussama Lagha <oussama.lagha@heig-vd.ch>
RUN apt-get update && \
apt-get install -y nano

COPY src /opt/app

CMD ["node","/opt/app/index.js"]
