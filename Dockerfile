FROM ruby:2.7.5

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN apt-get update -qq && apt-get install -y nodejs yarn
RUN mkdir /mangabestgram
WORKDIR /mangabestgram
COPY Gemfile /mangabestgram//Gemfile
COPY Gemfile.lock /mangabestgram//Gemfile.lock
RUN bundle install
COPY . /mangabestgram/

RUN yarn install --check-files
RUN bundle exec rails webpacker:compile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
