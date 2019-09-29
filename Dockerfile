FROM ruby:2.6.3-alpine
LABEL maintainer="bcrivelaro"

RUN apk --update add build-base nodejs yarn postgresql-client postgresql-dev \
    tzdata bash less && rm -rf /var/cache/apk/

ENV APP_HOME /gift_wishlist
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock package.json yarn.lock $APP_HOME/

RUN bundle install -j 4 --retry 5
RUN yarn install

COPY . $APP_HOME

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]