FROM ruby:3.0.0

RUN apt-get update -qq && \
  apt-get install -y apt-utils \
  build-essential \
  libpq-dev \
  nodejs \
  vim \
  default-mysql-client 

WORKDIR /factory

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install -j4

ADD . /factory

EXPOSE 3000