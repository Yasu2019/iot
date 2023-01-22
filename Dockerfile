FROM ruby:2.7.3
#Rails7.0.4 Ruby3.1 Mysql8.0 docker-compose で環境構築する。ついでにTailwindCSS と DaisyUI も入れちゃう。
#https://qiita.com/AGO523/items/0b5cc4e4d72c1fcf8c22
# npmをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm
# Daisyui UI をインストール
RUN npm i daisyui
# 追加 ==================
RUN apt-get update
RUN apt-get install vim -y
# ======================

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN apt-get update && apt-get install -y libvips42
RUN bundle install
COPY . /myapp

#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
#EXPOSE 3000

#COPY start.sh /start.sh
#RUN chmod 744 /start.sh
#CMD ["sh", "/start.sh"]

