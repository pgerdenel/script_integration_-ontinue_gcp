# docker build . -t app/flask:latest
# docker run -e APP_PORT=8080 -p 8080:8080 id_image
FROM python:3-alpine
RUN pip3 install flask
COPY ./server.py /usr/src/app/
CMD python3 /usr/src/app/server.py