ENV["RAILS_ENV"] ||= 'test'

require 'rspec'
require 'tap_if'

RSpec.configure do |c|
  c.mock_with :rspec
end
