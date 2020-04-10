# typed: false
# frozen_string_literal: true

class ArrayService < MiniService::Base
  arguments [:a]

  private

  def perform
    [a]
  end
end

RSpec.describe ArrayService do
  it 'works without optional arguments' do
    expect(described_class.call(a: 1)).to eq [1]
  end
end
