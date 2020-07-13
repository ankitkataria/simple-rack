FROM ruby:2.6-alpine

# set up workdir
RUN mkdir /simple-rack
WORKDIR /simple-rack

COPY Gemfile /simple-rack/Gemfile
COPY Gemfile.lock /simple-rack/Gemfile.lock

# Install gems
RUN gem install bundler
RUN bundle install

# Copy source
COPY . /simple-rack

# Expose server port
EXPOSE 3001

ENTRYPOINT "./entrypoint.sh"
