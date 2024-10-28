# syntax = docker/dockerfile:1

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t my-app .
# docker run -d -p 80:80 -p 443:443 --name my-app -e RAILS_MASTER_KEY=<value from config/master.key> my-app

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2.4
FROM docker.io/library/ruby:$RUBY_VERSION-slim

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    default-mysql-client \
    default-libmysqlclient-dev \
    libjemalloc2 \
    libvips \
    sqlite3 \
    libsqlite3-dev \
    git \
    pkg-config \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    OTEL_EXPORTER=otlp \
    OTEL_SERVICE_NAME=hello-pipelines \
    OTEL_RESOURCE_ATTRIBUTES=application="sparkapp rails server"

  
RUN gem update --system && gem install bundler --version=2.5.18

COPY . /usr/src/app

WORKDIR /usr/src/app

RUN bundle install

RUN bundle exec rake SECRET_KEY_BASE=1 RAILS_ENV=production assets:precompile

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]