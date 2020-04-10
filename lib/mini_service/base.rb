require 'mini_service/class_methods.rb'
require 'mini_service/instance_methods'

module MiniService
  class Base
    extend  MiniService::ClassMethods
    include MiniService::InstanceMethods
  end
end
