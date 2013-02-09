ENV["RAILS_ENV"] ||= 'test'

require 'rspec'

RSpec.configure do |c|
  c.mock_with :rspec
end
