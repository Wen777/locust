FROM wen777:ubuntu1404-locust-base
# FROM ubuntu:14.04
# Reference from github.com/hakobera/docker-locust

# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential curl libncursesw5-dev libreadline-dev libssl-dev libgdbm-dev libc6-dev libsqlite3-dev libxml2-dev libxslt-dev python python-dev python-setuptools python-pip && apt-get clean
# RUN pip install pyzmq

ADD . locust
WORKDIR /locust
RUN python setup.py install && cp run.sh  /usr/local/bin && chmod 755 /usr/local/bin/run.sh

EXPOSE 8089 5557 5558

CMD ["/usr/local/bin/run.sh"]
