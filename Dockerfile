FROM ubuntu:xenial

RUN apt-get update 

RUN apt-get install -y --no-install-recommends \
	wget \
	curl \
	git \
	zip \ 
	unzip 

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