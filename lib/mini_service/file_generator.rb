# typed: false
# frozen_string_literal: true

module Shift
  refine String do
    def shift(separator: "\n", shift: 2)
      split(separator).map! do |line|
        (' ' * shift) + line unless line.size.zero?
      end.join(separator)
    end
  end
end

module MiniService
  module FileGenerator
    using Shift

    class << self
      DEFAULT_TEXT = <<~DEFAULT
        private

        def perform
          # Put your code in here
          return nil
        end
      DEFAULT

      def file(array, args = [])
        [
          '# frozen_string_literal: true',
          '',
          superduper(array, text_with_arguments(args))
        ].compact.join("\n")
      end

      def text_with_arguments(args)
        [
          asdf(args) ? arguments(args) : nil,
          asdf(args) ? '' : nil,
          DEFAULT_TEXT
        ].compact.join("\n")
      end

      def asdf(args)
        args.any? ? arguments(args) : nil
      end

      def arguments(args)
        "arguments #{args.map(&method(:argument)).join(', ')}"
      end

      def argument(arg)
        if arg[':']
          arg.gsub(':', ': ')
        else
          ":#{arg}"
        end
      end

      def superduper(array, text, mode = :class)
        a = array.pop
        return text unless a

        superduper(array, super_text(a, mode, text), :module)
      end

      def module_end(name:, text: '', shift: 0)
        [
          "module #{name}".shift(shift: shift),
          shift_text(text: text, shift: shift + 2),
          shift_text(text: 'end', shift: shift)
        ].join("\n") + "\n"
      end

      def class_end(name:, text: '', shift: 0)
        [
          shift_text(text: "class #{name} < MiniService::Base", shift: shift),
          (text.size.zero? ? nil : shift_text(text: text, shift: shift + 2)),
          shift_text(text: 'end', shift: shift)
        ].compact.join("\n") + "\n"
      end

      def shift_text(text: '', separator: "\n", shift: 2)
        text.split(separator).map do |line|
          (' ' * shift) + line unless line.size.zero?
        end.join(separator)
      end

      private

      def super_text(name, mode, text)
        if mode == :class
          class_end(name: name, text: text)
        else
          module_end(name: name, text: text)
        end
      end
    end
  end
end
