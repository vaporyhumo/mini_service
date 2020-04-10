# typed: false
# frozen_string_literal: true

require 'mini_service'
require_relative 'version'
require_relative 'commands/generate'

module MiniService
  class CLI < Thor
    class Error < StandardError; end

    desc 'version', 'mini_service version'
    def version
      puts "v#{MiniService::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'generate', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def generate(name = nil, *arguments)
      generate_execute(arguments, name)
    rescue Error
      nil
    end

    private

    def generate_execute(arguments, name)
      if options[:help]
        invoke :help, ['generate']
      else
        MiniService::Commands::Generate.new(name, *arguments).execute
      end
    end
  end
end
