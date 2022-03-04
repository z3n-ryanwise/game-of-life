# require 'spec_helper'
# require_relative '../src/game_of_life'


# describe GameOfLife do
#   describe '#call' do
#     subject(:call) { described_class.call(input_state, grid_width: grid_width, grid_height: grid_height) }
#     let(:grid_width) { 3 }
#     let(:grid_height) { 3 }

#     context 'rule 1 - when a live cell has fewer than two live neighbours' do
#       let(:input_state) do
#         [
#           [0, 0, 0],
#           [0, 1, 0],
#           [0, 0, 0]
#         ]
#       end

#       it 'dies as if by underpopulation' do
#         expected_state = [
#           [0, 0, 0],
#           [0, 0, 0],
#           [0, 0, 0]
#         ]
#         expect(call).to eq(expected_state)
#       end
#     end

#     context 'rule 2 - when a live cell has two or three live neighbours' do
#       let(:input_states) do
#         [
#           [
#             [0, 1, 0],
#             [0, 1, 0],
#             [0, 0, 0]
#           ],
#           [
#             [0, 1, 0],
#             [0, 1, 1],
#             [0, 0, 0]
#           ],
#           [
#             [0, 1, 1],
#             [0, 1, 1],
#             [0, 0, 0]
#           ]
#         ]
#       end
#       let(:expected_states) do
#         [
#           [
#             [0, 1, 0],
#             [0, 1, 0],
#             [0, 0, 0]
#           ],
#           [
#             [0, 1, 0],
#             [0, 1, 1],
#             [0, 0, 0]
#           ],
#           [
#             [0, 1, 1],
#             [0, 1, 1],
#             [0, 0, 0]
#           ]
#         ]
#       end

#       it 'lives on to the next generation' do
#         output = input_states.map do |input|
#           described_class.call(input, grid_width: grid_width, grid_height: grid_height)
#         end

#         expect(output).to eq(:expected_states)
#       end
#     end

#     context 'rule 3 - when a live cell has more than 3 live neighbours' do
#       let(:input_states) do
#         [
#           [
#             [1, 1, 0],
#             [1, 1, 0],
#             [0, 0, 0]
#           ],
#           [
#             [1, 1, 1],
#             [1, 1, 1],
#             [1, 1, 1]
#           ],
#           [
#             [1, 1, 0],
#             [1, 1, 1],
#             [0, 0, 0]
#           ]
#         ]
#       end
#       let(:expected_states) do
#         [
#           [
#             [0, 0, 0],
#             [0, 0, 0],
#             [0, 0, 0]
#           ],
#           [
#             [0, 0, 0],
#             [0, 0, 0],
#             [0, 0, 0]
#           ],
#           [
#             [0, 0, 0],
#             [0, 0, 1],
#             [0, 0, 0]
#           ]
#         ]
#       end

#       it 'dies as if by overpopulation' do
#         output = input_states.map do |input|
#           described_class.call(input, grid_width: grid_width, grid_height: grid_height)
#         end

#         expect(output).to eq(:expected_states)
#       end
#     end

#     context 'rule 4 - a dead cell has exactly 3 live neighbours' do
#       let(:input_states) do
#         [
#           [
#             [1, 1, 0],
#             [1, 0, 0],
#             [0, 0, 0]
#           ],
#           [
#             [0, 1, 0],
#             [1, 0, 1],
#             [0, 0, 0]
#           ],
#           [
#             [1, 1, 1],
#             [1, 0, 0],
#             [0, 0, 0]
#           ]
#         ]
#       end
#       let(:expected_states) do
#         [
#           [
#             [1, 1, 0],
#             [1, 1, 0],
#             [0, 0, 0]
#           ],
#           [
#             [0, 1, 0],
#             [1, 1, 1],
#             [0, 0, 0]
#           ],
#           [
#             [1, 1, 0],
#             [1, 0, 0],
#             [0, 0, 0]
#           ]
#         ]
#       end
#       it 'becomes a live cell as if by reproduction' do
#         output = input_states.map do |input|
#           described_class.call(input, grid_width: grid_width, grid_height: grid_height)
#         end

#         expect(output).to eq(:expected_states)
#       end
#     end

#     context 'When a block of 4 come together' do
#       let(:start_state) do
#         [
#           [
#             [0, 0, 0, 0],
#             [0, 1, 1, 0],
#             [0, 1, 1, 0],
#             [0, 0, 0, 0]
#           ]
#         ]
#       end
#       it 'stays the same' do
#         output = described_class.call(start_state, grid_width: 4, grid_height: 4)

#         expect(output).to eq(start_state)
#       end
#     end

#     context 'When a line of three come together' do
#       let(:start_state) do
#         [
#           [
#             [0, 0, 0, 0, 0],
#             [0, 0, 0, 0, 0],
#             [0, 1, 1, 1, 0],
#             [0, 0, 0, 0, 0],
#             [0, 0, 0, 0, 0]
#           ]
#         ]
#       end
#       let(:expected_state) do
#         [
#           [
#             [0, 0, 0, 0, 0],
#             [0, 0, 1, 0, 0],
#             [0, 0, 1, 0, 0],
#             [0, 0, 1, 0, 0],
#             [0, 0, 0, 0, 0]
#           ]
#         ]
#       end
#       it 'should rotate 90 degrees' do
#         output = described_class.call(start_state, grid_width: 5, grid_height: 5)

#         expect(output).to eq(expected_state)
#       end
#       it 'should return to the start position after 2 calls' do
#         output = 2.times.reduce(start_state) do | state, index | 
#           state = described_class.call(start_state, grid_width: 5, grid_height: 5)
#         end

#         expect(output).to eq(start_state)
#       end
#     end
#   end
# end

