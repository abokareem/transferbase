FROM ruby:2.6.3

ENV APP_HOME /myapp
ENV BUNDLE_PATH /bundle

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

COPY . $APP_HOME

# Install gems, nodejs
RUN bundle install \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs

