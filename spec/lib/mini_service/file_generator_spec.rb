# typed: false
# frozen_string_literal: true

RSpec.describe MiniService::FileGenerator do
  it do
    expect(described_class.superduper([], 'hola')).to eq 'hola'
  end

  it do
    expect(described_class.superduper(['Service'], '')).to eq <<~ASDF
      class Service < MiniService::Base
      end
    ASDF
  end

  context 'when given an unmoduled class name' do
    let :expected_result do
      <<~ASDF
        class Service < MiniService::Base
          hola

          hola
        end
      ASDF
    end
    let :result do
      described_class.superduper ['Service'], <<~ASDF
        hola

        hola
      ASDF
    end

    it do
      expect(result).to eq expected_result
    end
  end

  context 'when given a deeply moduled class name' do
    let :expected_result do
      <<~A
        module Module
          module Other
            class Service < MiniService::Base
              text
            end
          end
        end
      A
    end
    let :result do
      described_class.superduper %w[Module Other Service], 'text'
    end

    it do
      expect(result).to eq expected_result
    end
  end

  context 'when given a moduled class name' do
    let :expected_result do
      <<~RESULT
        # frozen_string_literal: true

        module Module
          class Service < MiniService::Base
            private

            def perform
              # Put your code in here
              return nil
            end
          end
        end
      RESULT
    end
    let :result do
      described_class.file(%w[Module Service])
    end

    it do
      expect(result).to eq expected_result
    end
  end

  context 'when given arguments' do
    let :expected_result do
      <<~RESULT
        # frozen_string_literal: true

        class Service < MiniService::Base
          arguments :hola, chao: chao

          private

          def perform
            # Put your code in here
            return nil
          end
        end
      RESULT
    end
    let :result do
      described_class.file(%w[Service], ['hola', 'chao:chao'])
    end

    it do
      expect(result).to eq expected_result
    end
  end
end
