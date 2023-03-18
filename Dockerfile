FROM node:8

RUN npm config set registry https://registry.npm.taobao.org/

WORKDIR /my-yapi
# COPY my-yapi/version /my-yapi/vendors/
COPY my-yapi/1.12.0 /my-yapi/vendors/
COPY my-yapi/config.json /my-yapi/
COPY start.sh /my-yapi/

ENV TYPE=install

ENTRYPOINT [ "sh", "start.sh" ]

EXPOSE 3000