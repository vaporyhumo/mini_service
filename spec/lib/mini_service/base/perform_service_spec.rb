# typed: false
# frozen_string_literal: true

class PerformService < MiniService::Base
  private

  def perform
  end
end

RSpec.describe PerformService do
  describe '.new' do
    it 'raises NoMethodError when called directly' do
      expect do
        described_class.new
      end.to raise_error NoMethodError
    end
  end

  describe '.call' do
    context 'when called with no arguments' do
      it 'returns nil' do
        expect(described_class.call).to be_nil
      end
    end

    context 'when given extra arguments' do
      it 'raises ArgumentError' do
        expect { described_class.call(a: 1) }.to raise_error(
          ArgumentError
        )
      end
    end
  end
end
