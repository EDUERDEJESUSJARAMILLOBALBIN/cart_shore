# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rspec/rails'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'mongoid-rspec'

RSpec.configure do |config|
  config.include RSpec::Rails::ControllerExampleGroup, type: :controller
  config.include Mongoid::Matchers, type: :model
  config.include FactoryBot::Syntax::Methods # Agregar esta línea para incluir la sintaxis de FactoryBot
  config.before(:suite) do
    Mongoid.load!('config/mongoid.yml', :test)
  end
end
