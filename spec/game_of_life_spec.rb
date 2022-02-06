require 'spec_helper'
require_relative '../src/game_of_life'

describe GameOfLife do
  describe '#call' do
    subject(:call) { described_class.call(input_state, grid_width: grid_width, grid_height: grid_height) }
    let(:grid_width) { 3 }
    let(:grid_height) { 3 }

    context "when there is fewer than two live neighbours" do
      let(:input_state) do
        [
          [0,0,0],
          [0,1,0],
          [0,0,0]
        ]
      end
      let(:expected_state) do
        [
          [0,0,0],
          [0,0,0],
          [0,0,0]
        ]
      end

      it "it dies as if by underpopulation" do
        expect(call).to eq expected_state
      end
    end

    # context "when there are 2 or 3 live neighbours" do
    #   let(:input_state) do
    #     [
    #       [0,0,0],
    #       [0,1,0],
    #       [0,0,0]
    #     ]
    #   end
    #   let(:expected_state) do
    #     [
    #       [0,0,0],
    #       [0,0,0],
    #       [0,0,0]
    #     ]
    #   end

    #   it "it continues to live on" do
    #     expect(call).to eq expected_state
    #   end
    # end
  end
end