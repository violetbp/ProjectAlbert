# Load the Rails application.
require File.expand_path('../application', __FILE__)

# force Rails into production mode when                          
# you don't control web/app server and can't set it the proper way                  
ENV['RAILS_ENV'] ||= 'production'

# Initialize the Rails application.
Rails.application.initialize!

