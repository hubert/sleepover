FROM ruby:latest

# Run updates
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Set up working directory
RUN mkdir -p /var/www/sleepover  
WORKDIR /var/www/sleepover  

# Set up ssh keys
RUN mkdir -p ~/.ssh
COPY id_rsa ~/.ssh/

# Set up gems
ADD Gemfile /var/www/sleepover/Gemfile  
ADD Gemfile.lock /var/www/sleepover/Gemfile.lock  
RUN bundle install

# Finally, add the rest of our app's code
# (this is done at the end so that changes to our app's code
# don't bust Docker's cache)
ADD . /var/www/sleepover
