require 'active_support'
module MiniService
  module ClassMethods
    def call(*args)
      raise MiniService::ArgumentsNotHashError unless args[0].is_a?(Hash)

      new(*args).call
    end

    def mini_reqs(array)
      mattr_accessor :reqd_args
      self.reqd_args = array
    end

    def mini_lets(array)
      mattr_accessor :letd_args
      self.letd_args = array
    end
  end
end
