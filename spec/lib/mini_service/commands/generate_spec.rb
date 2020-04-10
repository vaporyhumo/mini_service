# typed: false
# frozen_string_literal: true

require 'mini_service/commands/generate'

RSpec.describe MiniService::Commands::Generate do
  let :expected_output do
    space = ' '
    <<~OUTPUT
      @name: Hola
      @arguments:#{space}
      parsed_name: hola
      OK
    OUTPUT
  end

  after do
    TTY::File.remove_file 'lib/services/hola.rb'
  end

  it 'executes `generate` command successfully' do
    output = StringIO.new
    options = 'Hola'
    $stdin = StringIO.new("\n")
    described_class.new(options).execute(output: output)

    expect(output.string).to eq(expected_output)
  end

  context 'when interrupted' do
    before do
      allow_any_instance_of(described_class).to receive(:ask_name) do
        raise TTY::Reader::InputInterrupt
      end
    end

    it do
      output = StringIO.new

      expect do
        described_class.new(nil).execute(output: output)
      end.to raise_error MiniService::Error
    end
  end

  it do
    output = StringIO.new
    $stdin = StringIO.new("Hola\n\n")
    described_class.new(nil).execute(output: output)

    expect(output.string).to eq(expected_output)
  end
end
