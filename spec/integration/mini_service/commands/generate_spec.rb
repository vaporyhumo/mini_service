# typed: false
# frozen_string_literal: true

require 'mini_service/commands/generate'

RSpec.describe MiniService::Commands::Generate, type: :cli do
  describe '`mini_service generate` command' do
    let(:expected_output) do
      <<~OUT
        Usage:
          mini_service generate

        Options:
          -h, [--help], [--no-help]  # Display usage information

        Command description...
      OUT
    end

    it 'executes `mini_service help generate` command successfully' do
      output = `mini_service help generate`

      expect(output).to eq(expected_output)
    end
  end
end
