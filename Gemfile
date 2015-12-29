source 'https://rubygems.org'

gemspec

gem 'overcommit', '~> 0.29'
gem 'rake', '~> 10.4'
gem 'rspec', '~> 3.4'
gem 'rubocop', '~> 0.35'
gem 'simplecov', '~> 0.11'
gem 'travis', '~> 1.8'

group :test do
  gem 'codeclimate-test-reporter', require: false
end

local_gemfile = 'Gemfile.local'

if File.exist?(local_gemfile)
  eval(File.read(local_gemfile)) # rubocop:disable Lint/Eval
end