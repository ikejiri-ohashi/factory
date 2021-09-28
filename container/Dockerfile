FROM ruby:3.0.0

## nodejsとyarnはwebpackをインストールする際に必要
# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN apt-get update -qq && apt-get install -y nodejs yarn
RUN mkdir /factory
WORKDIR /factory
COPY Gemfile /factory/Gemfile
COPY Gemfile.lock /factory/Gemfile.lock
RUN bundle install
COPY . /factory

RUN yarn install --check-files
# RUN bundle exec rails webpacker:compile

EXPOSE 3000