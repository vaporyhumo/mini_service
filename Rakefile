# frozen_string_literal: true

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

# require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts 'RSpec loading failed'
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new

# task :sorbet do
#   system 'bundle exec srb rbi sorbet-typed'
#   system 'bundle exec srb rbi gems'
#
#   sh 'bundle', 'exec', 'srb', 't'
# end

task :default do
  # Rake::Task['sorbet'].invoke
  Rake::Task['spec'].invoke
  Rake::Task['rubocop'].invoke
end

# Bundler::GemHelper.install_tasks
