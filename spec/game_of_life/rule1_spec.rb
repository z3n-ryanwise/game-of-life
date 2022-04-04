require 'spec_helper'
require_relative '../../src/game_of_life/rule1'

describe GameOfLife::Rule1 do
  context 'Local Underpopulation' do
    let(:state) do
      [
        [0, 1, 1, 1, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]
    end

    let(:expected_alive_cells) { [[0, 2]] }

    it 'returns true for the expected alive cells' do
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

  context 'Boundary underpopulation' do
    let(:state) do
      [
        [1, 1, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0],
        [0, 0, 1, 0, 1, 0]
      ]
    end

    let(:expected_alive_cells) { [[0, 1], [4, 4]] }

    it 'returns true for the expected alive cells' do
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
