# typed: strict
# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'thor'
require 'tty-file'
require 'tty-prompt'

require 'mini_service/base'
require 'mini_service/error'
require 'mini_service/file_generator'
require 'mini_service/version'

module MiniService
end
