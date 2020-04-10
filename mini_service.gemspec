# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'mini_service/version'

Gem::Specification.new do |spec|
  spec.name = 'mini_service'
  # spec.license = ''
  spec.version = MiniService::VERSION
  spec.authors = ['@vaporyhumo']
  spec.email = ['roanvilina@gmail.com']

  spec.summary = 'A base class for services.'
  spec.description = 'Services do one thing and then vanish, POOF!~'
  spec.homepage = 'https://www.github.com/vaporyhumo/mini_service'

  spec.required_ruby_version = Gem::Requirement.new('>=2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] =
    'https://github.com/vaporyhumo/mini_service/blob/master/CHANGELOG.md'
  spec.files = Dir['lib/**/*.rb', 'exe/**/*']

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'tty-file'
  spec.add_runtime_dependency 'tty-prompt'
end
