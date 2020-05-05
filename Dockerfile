FROM ruby:2.6.5
RUN apt update -qq && apt install --no-install-recommends -y build-essential nodejs yarn postgresql-client vim
RUN mkdir /src
WORKDIR /src
COPY Gemfile /src/Gemfile
COPY Gemfile.lock /src/Gemfile.lock
RUN bundle install
COPY . /src

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]