FROM ruby:3.0.0
# 開発環境用の記述
ENV RAILS_ENV=production

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

# 開発環境用の記述
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

VOLUME /factory/public
VOLUME /factory/tmp

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"