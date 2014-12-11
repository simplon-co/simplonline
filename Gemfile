source 'https://rubygems.org'

ruby '2.1.3'

gem 'forem', :github => "radar/forem", :branch => "rails4"
#gem 'forem-bootstrap', github: "radar/forem-bootstrap"
#gem 'forem-redcarpet', github: "radar/forem-redcarpet"
gem 'cancan'

gem 'rails', '4.1.1'
gem 'pg'

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

gem 'jbuilder', '~> 2.0'

gem 'therubyracer'

gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'foreman'

gem 'carrierwave'
gem 'font-awesome-sass'
gem 'haml'
gem 'nested_form'
gem 'kaminari'

gem "redcarpet"
gem 'coderay'

gem 'bcrypt'

gem 'dotenv-rails', :groups => [:development, :test]


gem 'newrelic_rpm', groups: [:production]
gem 'rails_12factor', groups: [:production]
gem 'puma', groups: [:production]
gem 'rollbar', groups: [:production]

group :development do
  gem 'traceroute'
  gem 'bullet'
  gem 'rack-livereload'
  gem 'pry-rescue'
  gem 'factory_girl_rails'
  gem "rails_best_practices"
  gem 'rubocop', require: false
  gem "rubycritic", :require => false
end

group :test do
  gem 'minitest-color'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'colored'
  gem 'deadweight', :require => 'deadweight/hijack/rails'
end

