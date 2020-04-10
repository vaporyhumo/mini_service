# typed: false
# frozen_string_literal: true

require 'forwardable'

module MiniService
  class Command
    extend Forwardable

    def_delegators :command, :run

    def generator
      require 'tty-file'
      TTY::File
    end

    def prompt(**options)
      require 'tty-prompt'
      TTY::Prompt.new(options)
    end
  end
end
