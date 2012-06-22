require 'rspec'
require 'faraday'
require 'nokogiri'
require './lib/zillow_demographics'
require 'client_spec'
# require 'people_spec'
# require 'national_spec'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end