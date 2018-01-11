FROM ubuntu:xenial

RUN apt-get update 

RUN apt-get install -y --no-install-recommends \
	wget \
	curl \
	git \
	zip \ 
	unzip \
	openjdk-8-jre

RUN apt-get install ruby-full -y 

RUN apt-get install -y imagemagick libmagickwand-dev
RUN apt-get install -y build-essential
RUN apt-get update
RUN apt-get clean

RUN gem install nokogiri -v '1.8.1'

ADD Gemfile /
RUN apt-get install bundler -y
RUN bundle install

# set timezone
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# set env variables
ENV FF_VERSION="40.0.3"

# install libs, xvfb and firefox
RUN apt-get update && apt-get install -y zlib1g-dev xvfb libxcomposite1 libasound2 libdbus-glib-1-2 libgtk2.0-0
RUN wget "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FF_VERSION}/linux-x86_64/en-US/firefox-${FF_VERSION}.tar.bz2" \
    -O /tmp/firefox.tar.bz2 && \
    tar xvf /tmp/firefox.tar.bz2 -C /opt && \
    ln -s /opt/firefox/firefox /usr/bin/firefox

ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins
LABEL Description="This is a base image, which provides the Jenkins agent executable (slave.jar)" Vendor="Jenkins project" Version="3.16"

ARG VERSION=3.16
ARG AGENT_WORKDIR=/home/jenkins/agent

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/jenkins/.jenkins && mkdir -p ${AGENT_WORKDIR}

VOLUME /home/jenkins/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/jenkins

COPY jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod 777 /usr/local/bin/jenkins-slave
ENTRYPOINT jenkins-slave