lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mini_service/version'

Gem::Specification.new do |spec|
  spec.name     = 'mini_service'
  spec.version  = MiniService::VERSION
  spec.authors  = ['Rodrgo Andrés Contreras Vilina']
  spec.email    = ['roanvilina@gmail.com']

  spec.summary  = 'Provides a simple service prototype class and its generator.'
  spec.homepage = 'https://github.com/roanvilina/mini_service'
  spec.license  = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'irb'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'activesupport', '~> 4.2.0'
end
