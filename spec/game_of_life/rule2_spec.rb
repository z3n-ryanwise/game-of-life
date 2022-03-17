require 'spec_helper'
require_relative '../../src/game_of_life/rule2'

describe GameOfLife::Rule2 do
  context 'Local stable population' do
    let(:state) do
      [
        [0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 1, 1, 0],
        [0, 1, 1, 0, 0],
        [0, 0, 0, 1, 0]
      ]
    end
    let(:ex) do
      [
        [[0, 0], [0, 1]],
        [[1, 0], [1, 1]]
      ]
    end

    let(:expected_alive_cells) { [[1, 2], [2, 3], [3, 1]] }

    it 'returns true for any expected alive cells' do
      expected_alive_cells.each do |cell|
        expect(described_class.rule2(state, cell)).to eq(true)
      end
    end

    it 'returns false cell [2, 2] ' do
      expect(described_class.rule2(state, [2, 2])).to eq(false)
    end

    it 'returns false cell [3, 2] ' do
      expect(described_class.rule2(state, [3, 2])).to eq(false)
    end

    it 'returns false cell [4, 3] ' do
      expect(described_class.rule2(state, [4, 3])).to eq(false)
    end
  end
end
