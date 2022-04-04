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

  context 'when applying default rules and given a block of four live cells' do
    let(:state) do
      [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0]
      ]
    end
    let(:expected_state) do
      [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0]
      ]
    end
    it 'should never change and never die' do
      expect(described_class.call(state)).to eq(expected_state)
    end
  end

  context 'when applying default rules and given a line of three live cells' do
    let(:state) do
      [
        [0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0]
      ]
    end
    let(:expected_state) do
      [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 1, 1, 1, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]
    end
    it 'the line should stay the same length and rotate 90 degress' do
      expect(described_class.call(state)).to eq(expected_state)
    end
    it 'such that on a second pass it will switch back to its starting position' do
      start_state = state
      state = described_class.call(start_state)
      expect(described_class.call(state)).to eq(start_state)
    end
  end

  context 'with special rule xyz' do
    let(:state) do
      [[
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ],
       [
         [1, 1, 1],
         [1, 1, 1],
         [1, 1, 1]
       ]]
    end
    let(:expected_state) do
      [[
        [1, 1, 1],
        [1, 1, 1],
        [1, 1, 1]
      ],
       [
         [0, 0, 0],
         [0, 0, 0],
         [0, 0, 0]
       ]]
    end
    let(:rules) do
      [
        [
          ->(_, _) { true }
        ],
        [
          ->(_, _) { false }
        ]
      ]
    end
    it 'returns state as a with all values switched to one' do
      expect(described_class.call(state[0], rules[0])).to eq(expected_state[0])
    end
    it 'returns with all values switched to zero' do
      expect(described_class.call(state[1], rules[1])).to eq(expected_state[1])
    end
    it 'applies the rules in the order specified' do
      expect(described_class.call(state[1], [rules[1], rules[0]].flatten)).to eq(expected_state[0])
      expect(described_class.call(state[1], [rules[0], rules[1]].flatten)).to eq(expected_state[1])
    end
  end
end
