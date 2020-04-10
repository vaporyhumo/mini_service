# typed: false
# frozen_string_literal: true

require_relative '../../../lib/mini_service/command'

module MiniService
  module Commands
    class Generate < MiniService::Command
      class NameError < Error; end

      def initialize(name, *arguments)
        @name = name
        @arguments = arguments
        ask_name
      rescue TTY::Reader::InputInterrupt
        puts "\nNot OK"
      end

      attr_reader :name, :arguments

      def execute(_input: $stdin, output: $stdout)
        raise NameError unless name

        puts_info output: output
        generator.create_file location, file_content
        output.puts 'OK'
      end

      def ask_name
        unless name
          @name = prompt.ask 'Name? '
        end
      end

      def location
        prompt.select 'Dónde?', select_options
      end

      def file_content
        MiniService::FileGenerator.file name.split('::'), arguments
      end

      def puts_info(output:)
        output.puts "@name: #{name}"
        output.puts "@arguments: #{arguments.join(', ')}"
        output.puts "parsed_name: #{parsed_name}"
      end

      def select_options
        options = ['lib/services'] + Dir['**/services']
        options.map! { |item| item + '/' + parsed_name + '.rb' }
        options.uniq
      end

      def parsed_name
        underscore(name)
      end

      def underscore(camel_cased_word)
        return camel_cased_word unless %r{[A-Z-]|::}.match?(camel_cased_word)

        subd_word camel_cased_word.to_s.gsub('::', '/')
      end

      def subd_word(word)
        word.gsub!(%r{([A-Z\d]+)([A-Z][a-z])}, '\1_\2')
        word.gsub!(%r{([a-z\d])([A-Z])}, '\1_\2')
        word.tr!('-', '_')
        word.downcase!
      end
    end
  end
end
