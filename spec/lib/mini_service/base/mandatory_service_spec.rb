# typed: false
# frozen_string_literal: true

class MandatoryService < MiniService::Base
  arguments :a, :b

  private

  def perform
    [a, b]
  end
end

RSpec.describe MandatoryService do
  describe '.new' do
    it 'raises NoMethodError when called directly' do
      expect do
        described_class.new
      end.to raise_error NoMethodError
    end
  end

  describe '.call' do
    context 'when called with missing arguments' do
      it 'raises ArgumentError' do
        expect do
          described_class.call a: 1
        end.to raise_error ArgumentError
      end
    end

    context 'when called with extra arguments' do
      it 'raises ArgumentError' do
        expect do
          described_class.call a: 1, b: 1, c: 1
        end.to raise_error ArgumentError
      end
    end

    context 'when called with all required and none extra arguments' do
      it 'performs correctly' do
        expect(described_class.call(a: 1, b: 2)).to eq [1, 2]
      end
    end
  end
end
