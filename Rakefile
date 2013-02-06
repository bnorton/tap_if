# encoding: UTF-8
require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name        = 'tap-if'
  gem.homepage    = 'http://github.com/bnorton/tap-if'
  gem.license     = 'MIT'
  gem.summary     = 'Tap into an object but only execute the code if truthy.'
  gem.description = 'Object#tap_if clarifies control flow in many circumstances.'
  gem.email       = 'brian.nort@gmail.com'
  gem.authors     = %w(bnorton)
end

Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec
