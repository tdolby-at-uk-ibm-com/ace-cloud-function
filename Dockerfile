# Copyright (c) 2021 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)

#########################################################################
#
# This IBM Cloud Functions ACE image is built on top of the python 3.7
# image for convenience; a "proper" image would not need python and would
# be significantly smaller!
#
#########################################################################
FROM tdolby/experimental:ace-minimal-12.0.1.0-alpine

#
# Instructions for buiding and creating the cloud function:
# 
# docker build -t tdolby/experimental:ace12-cloud-function -f Dockerfile .
# docker push tdolby/experimental:ace12-cloud-function
# cd app
# ibmcloud target -o tdolby@uk.ibm.com -s dev
# ibmcloud fn action create --web yes get-http-resource/ace-cloud-function --docker tdolby/experimental:ace12-cloud-function python-code.py
#
MAINTAINER Trevor Dolby <tdolby@uk.ibm.com> (@tdolby)

COPY aceFunction.bar /tmp/aceFunction.bar

# Switch off the admin REST API for the server run, as we won't be deploying anything after start
RUN sed -i 's/#port: 7600/port: -1/g' /home/aceuser/ace-server/server.conf.yaml 


# From https://github.com/IBM/ibm-cloud-functions-polyglot-development/blob/master/dockerSkeleton

ENV FLASK_PROXY_PORT 8080

ENV PYTHONUNBUFFERED 1

USER root
# Upgrade and install basic Python dependencies
RUN apk add --no-cache python2 \
 && python -m ensurepip \
 && rm -rf /usr/lib/python*/ensurepip \
 && pip install --upgrade pip setuptools \
 && rm -rf /root/.cache \
 && pip install flask requests

COPY run-server.sh /home/aceuser/run-server.sh
RUN chmod -R 777 /home/aceuser

RUN mkdir -p /actionProxy
ADD actionproxy.py /actionProxy/

RUN mkdir -p /action
#ADD exec-python-code.py /action/exec
ADD run-server.sh /action/exec
RUN chmod +x /action/exec

# Deploy the BAR file
RUN  su - aceuser -c "export LICENSE=accept && . /opt/ibm/ace-12/server/bin/mqsiprofile &&  mqsibar -c -a /tmp/aceFunction.bar -w /home/aceuser/ace-server"

ENV LICENSE accept

CMD ["/bin/bash", "-c", "cd actionProxy && python -u actionproxy.py"]




