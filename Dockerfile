FROM ruby:3.0.0

#本番環境用の記述
ENV RAILS_ENV=production

## nodejsとyarnはwebpackをインストールする際に必要
# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN apt-get update -qq && apt-get install -y nodejs yarn && yarn install n -g && n 12.13.0
RUN mkdir /factory
WORKDIR /factory
COPY Gemfile /factory/Gemfile
COPY Gemfile.lock /factory/Gemfile.lock
RUN bundle install
COPY . /factory

RUN yarn install --check-files
RUN bundle exec rails webpacker:compile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

#本番環境用
VOLUME /app/public
VOLUME /app/tmp

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
