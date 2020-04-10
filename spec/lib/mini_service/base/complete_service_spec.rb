# typed: false
# frozen_string_literal: true

class CompleteService < MiniService::Base
  arguments :a, b: 1

  private

  def perform
    [a, b]
  end
end

RSpec.describe CompleteService do
  it 'works without optional arguments' do
    expect(described_class.call(a: 1, b: 2)).to eq [1, 2]
  end

  it 'works with optional arguments' do
    expect(described_class.call(a: 1)).to eq [1, 1]
  end
end
