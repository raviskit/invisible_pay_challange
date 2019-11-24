FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /app
WORKDIR /app


COPY . /app/
RUN gem install bundler && bundle install

EXPOSE 8081
CMD rm -f tmp/pids/server.pid && rails server -p 8081 -b 0.0.0.0


