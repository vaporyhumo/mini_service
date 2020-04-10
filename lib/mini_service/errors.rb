module MiniService
  class MissingArgumentsError < StandardError; end
  class UnallowedArgumentsError < StandardError; end
  class ArgumentsNotHashError < StandardError; end
end
