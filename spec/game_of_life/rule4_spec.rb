require 'spec_helper'
require_relative '../../src/game_of_life/rule4'

describe GameOfLife::Rule4 do
  context 'Local reproduction' do
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

    let(:expected_alive_cells) { [[1, 2], [1, 3], [2, 2], [2, 3], [3, 1], [3, 2], [4, 2], [4, 3]] }

    it 'returns true for any expected alive cells' do
      expected_alive_cells.each do |cell|
        expect(described_class.call(state, cell)).to eq(true)
      end
    end

    it 'returns false for other cells' do
      state.each_with_index do |row, row_position|
        row.each_with_index do |_col, col_position|
          cell_coordinate = [row_position, col_position]
          unless expected_alive_cells.include?(cell_coordinate)
            expect(described_class.call(state, cell_coordinate)).to eq(false)
          end
        end
      end
    end
  end
end
