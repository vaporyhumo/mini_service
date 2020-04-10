# typed: true
# frozen_string_literal: true

module MiniService
  class Base
    class ExtraArgumentError < ArgumentError; end
    class MissingArgumentError < ArgumentError; end

    private_class_method :new

    class << self
      attr_accessor :required
      attr_accessor :optional
      attr_reader :opts

      def set_initial_values(req, opt)
        @required ||= req || []
        @optional ||= opt || {}
        nil
      end

      def arguments(*req, **opt)
        add_required_arguments(req)
        add_optional_arguments(opt)

        define_readers
      end

      def add_required_arguments(arguments)
        arguments.each(&method(:add_required_argument))
      end

      def add_optional_arguments(options)
        optional.merge!(options)
      end

      def add_required_argument(argument)
        case argument
        when Symbol, String then required << argument
        when Array then add_required_arguments(argument)
        end
      end

      def define_readers
        required.each { |r| attr_reader r }
        optional.each_key { |r| attr_reader r }
      end

      def inherited(subclass)
        subclass.set_initial_values(required, optional)
        subclass.arguments
      end

      def call(**opts)
        @opts = opts
        validate_extra_arguments
        validate_missing_arguments

        new(**optional.merge(opts)).send :perform
      end

      def validate_extra_arguments
        if extra_arguments.any?
          raise ExtraArgumentError,
                "Extra arguments: #{extra_arguments.join(', ')}"
        end
      end

      def validate_missing_arguments
        if missing_arguments.any?
          raise MissingArgumentError,
                "Missing arguments: #{missing_arguments.join(', ')}"
        end
      end

      def missing_arguments
        (required - opts.keys)
      end

      def extra_arguments
        (opts.keys - (required + optional.keys))
      end
    end

    private

    def initialize(opts)
      opts.each do |key, value|
        instance_variable_set "@#{key}", value
      end
    end

    def perform
      raise NoMethodError,
            'Please define the private instance method perform'
    end
  end
end
