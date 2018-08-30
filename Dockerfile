FROM ubuntu:latest
MAINTAINER Ed "ted@naxxus.net"
RUN apt-get update -y && apt-get install -y python-pip python-dev build-essential zlib1g-dev 
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
#RUN python -m pip install cx_Freeze --upgrade 
RUN pyinstaller --onefile app.py
RUN pwd
RUN ls -lah dist/app

FROM ubuntu:latest
COPY --from=0 /app/dist/* /tmp/dist/
ARG CONFIGMAP=not_set_yet
ENV CONFIGMAP $CONFIGMAP
ENTRYPOINT ["/tmp/dist/app", "splain"]
