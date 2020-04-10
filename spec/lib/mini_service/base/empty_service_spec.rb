# typed: false
# frozen_string_literal: true

class EmptyService < MiniService::Base
end

RSpec.describe EmptyService do
  describe '.new' do
    it 'raises NoMethodError when called directly' do
      message = "private method `new' called for #{described_class}:Class"
      expect do
        described_class.new
      end.to raise_error NoMethodError, message
    end
  end

  describe '.call' do
    context 'when #perform is not defined' do
      it 'raises NoMethodError' do
        expect do
          described_class.call
        end.to raise_error NoMethodError,
                           'Please define the private instance method perform'
      end

      it 'raises ArgumentError when given any kind of params' do
        expect do
          described_class.call a: 1
        end.to raise_error ArgumentError # , ''
      end
    end
  end
end
