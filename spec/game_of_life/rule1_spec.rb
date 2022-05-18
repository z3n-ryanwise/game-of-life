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

    let(:skipped_cells_for_rule) { [[0, 2]] }

    it 'returns 0 for the cells skipped for rule' do
      skipped_cells_for_rule.each do |cell|
        expect(described_class.call(state, cell)).to eq(0)
      end
    end

    it 'returns -1 for cells that would be killed by rule' do
      state.each_with_index do |row, row_position|
        row.each_with_index do |_col, col_position|
          cell_coordinate = [row_position, col_position]
          unless skipped_cells_for_rule.include?(cell_coordinate)
            expect(described_class.call(state, cell_coordinate)).to eq(-1)
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

    let(:skipped_cells_for_rule) { [[0, 1], [4, 4]] }

    it 'returns 0 for the cells skipped for rule' do
      skipped_cells_for_rule.each do |cell|
        expect(described_class.call(state, cell)).to eq(0)
      end
    end

    it 'returns -1 for cells that would be killed by rule' do
      state.each_with_index do |row, row_position|
        row.each_with_index do |_col, col_position|
          cell_coordinate = [row_position, col_position]
          unless skipped_cells_for_rule.include?(cell_coordinate)
            expect(described_class.call(state, cell_coordinate)).to eq(-1)
          end
        end
      end
    end
  end
end
