FROM nginx:alpine

#ADD deploy/ /etc/
COPY dist/ /usr/share/nginx/html/

ENV TZ Asia/ShangHai
