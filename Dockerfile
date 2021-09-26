FROM ruby:3.0.0

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /factory
WORKDIR /factory

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /factory//Gemfile
ADD Gemfile.lock /factory//Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /factory

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets