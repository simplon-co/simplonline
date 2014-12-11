require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Sensei
  class Application < Rails::Application
    config.time_zone = 'Europe/Paris'
    config.i18n.default_locale = :fr
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
  end
end


