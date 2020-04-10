# typed: false
# frozen_string_literal: true

class OptionalService < MiniService::Base
  arguments a: 1

  private

  def perform
    [a]
  end
end

RSpec.describe OptionalService do
  describe '.new' do
    it 'raises NoMethodError when called directly' do
      expect do
        described_class.new
      end.to raise_error NoMethodError # , ''
    end
  end

  describe '.call' do
    context 'when called with extra arguments' do
      it 'raises ArgumentError' do
        expect do
          described_class.call a: 1, b: 1
        end.to raise_error ArgumentError
      end
    end

    context 'when called with no arguments' do
      it 'performs correctly' do
        expect(described_class.call).to eq [1]
      end
    end
  end
end
