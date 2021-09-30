FROM ruby:3.0.2
# 開発環境用の記述
ENV RAILS_ENV=production

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get update && \
    apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev sudo vim

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn && apt-get install imagemagick


RUN yarn add node-sass

WORKDIR /factory
RUN mkdir -p tmp/pids
RUN mkdir -p tmp/sockets
COPY Gemfile /factory/Gemfile
COPY Gemfile.lock /factory/Gemfile.lock
COPY yarn.lock /factory
COPY package.json /factory
RUN bundle install
# ここでyarn installをしないとwebpackerを実行できない
RUN yarn install
COPY . /factory

RUN rails webpacker:install
RUN NODE_ENV=production ./bin/webpack

EXPOSE 3000

# 開発環境用の記述
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

VOLUME /factory/public
VOLUME /factory/tmp

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -e production"