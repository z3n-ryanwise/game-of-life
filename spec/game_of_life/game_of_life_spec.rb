require 'spec_helper'
require_relative '../../src/game_of_life/main'

describe GameOfLife::Main do
  context 'when input is an empty array' do
    let(:state) do
      [
        []
      ]
    end
    let(:rules) { [] }

    it 'returns state as a 2d array' do
      expect(described_class.call(state, rules)).to eq([[]])
    end
  end
  context 'when input is an empty populated array' do
    let(:state) do
      [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]
    end
    let(:expected_state) do
      [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]
    end
    let(:rules) { [] }
    it 'returns state as a 2d array' do
      expect(described_class.call(state, rules)).to eq(expected_state)
    end
  end

  # context 'when input is an empty populated array' do
  #   let(:state) do
  #     [
  #       [0, 0, 0],
  #       [0, 1, 0],
  #       [0, 0, 0]
  #     ]
  #   end
  #   let(:expected_state) do
  #     [
  #       [0, 0, 0],
  #       [0, 0, 0],
  #       [0, 0, 0]
  #     ]
  #   end
  #   it 'returns state as a 2d array' do
  #     expect(described_class.call(state)).to eq(expected_state)
  #   end

  # end

  context 'with special rule xyz' do
    let(:state) do
      [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]
    end
    let(:expected_state) do
      [
        [1, 1, 1],
        [1, 1, 1],
        [1, 1, 1]
      ]
    end
    let(:rules) do
      [-> (_) { true }]
    end
    it 'returns state as a 2d array' do
      expect(described_class.call(state, rules)).to eq(expected_state)
    end
  end
end
