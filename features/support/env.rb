require 'bundler'
require 'capybara/dsl'
require 'capybara/rspec'

Bundler.require()
include Capybara::DSL
include RSpec::Matchers

require_rel '../../lib/pages/*.rb'
# Selenium::WebDriver::Chrome.driver_path="~/Downloads/chromedriver"

Capybara.default_driver = :selenium
# Capybara.current_session.current_window.resize_to(1920,1080)

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

 Capybara.default_selector = :css

World(Capybara::DSL)