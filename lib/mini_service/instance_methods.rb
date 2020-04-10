require 'mini_service/errors'

module MiniService
  module InstanceMethods
    def initialize(args)
      instance_variables(args)
    end

    def call
      perform
    end

    private

    def instance_variables(args)
      raise MiniService::MissingArgumentsError if missing_arguments?(args)

      args.each do |key, value|
        raise MiniService::ExtraArgumentsError unless argument_allowed?(key)

        instance_variable_set "@#{key}", value
      end
    end

    def argument_allowed?(key)
      @alwd_args ||= allowed_arguments
      return true if @alwd_args.empty?

      @alwd_args.include? key
    end

    def allowed_arguments
      alwd_args = []
      alwd_args << letd_args if letd_args_defined?
      alwd_args << reqd_args if reqd_args_defined?
      alwd_args.flatten
    end

    def missing_arguments?(args)
      return false unless reqd_args_defined?

      (reqd_args - args.keys).any?
    end

    def reqd_args_defined?
      !defined?(reqd_args).nil?
    end

    def letd_args_defined?
      !defined?(letd_args).nil?
    end
  end
end
