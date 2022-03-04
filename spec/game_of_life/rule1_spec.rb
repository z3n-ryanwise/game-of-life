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
        expect(described_class.rule1(state, cell)).to eq(true)
      end
    end

    it 'returns false for other cells' do
      state.each_with_index do |row, row_position|
        row.each_with_index do |_col, col_position|
          cell_coordinate = [row_position, col_position]
          unless expected_alive_cells.include?(cell_coordinate)
            expect(described_class.rule1(state, cell_coordinate)).to eq(false)
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
        expect(described_class.rule1(state, cell)).to eq(true)
      end
    end

    it 'returns false for other cells' do
      state.each_with_index do |row, row_position|
        row.each_with_index do |_col, col_position|
          cell_coordinate = [row_position, col_position]
          unless expected_alive_cells.include?(cell_coordinate)
            expect(described_class.rule1(state, cell_coordinate)).to eq(false)
          end
        end
      end
    end

    # it 'any cell with fewer than two live cells returns false' do
    #   expect(GameOfLife.rule1(state, [0,0])).to eq(false)
    #   expect(GameOfLife.rule1(state, [4,2])).to eq(false)
    #   expect(GameOfLife.rule1(state, [0,4])).to eq(false)
    #   expect(GameOfLife.rule1(state, [3,4])).to eq(false)
    # end

    # it 'any live cell with two or more live cells returns true' do
    #   expect(GameOfLife.rule1(state, [0,1])).to eq(true)
    #   expect(GameOfLife.rule1(state, [4,4])).to eq(true)
    # end
  end
end
