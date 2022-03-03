require 'spec_helper'
require_relative '../src/game_of_life'

# describe GameOfLife do
#   describe '#call' do
#     subject(:call) { described_class.call(input_state, grid_width: grid_width, grid_height: grid_height) }
#     let(:grid_width) { 3 }
#     let(:grid_height) { 3 }

#     context "rule 1 - when there is fewer than two live neighbours" do
# let(:input_state) do
#   [
#     [0,0,0],
#     [0,1,0],
#     [0,0,0]
#   ]
# end
# let(:expected_state) do
#   [
#     [0,0,0],
#     [0,0,0],
#     [0,0,0]
#   ]
# end

# it "it dies as if by underpopulation" do
#   expect(call).to eq expected_state
# end

# let(:input_states) do
#   [
#     [
#       [0,0,0],
#       [0,1,0],
#       [0,0,0]
#      ],
#      [
#       [0,0,0],
#       [0,1,0],
#       [0,0,0]
#      ]
#   ]
# end
# let(:expected_states) do
#   [
#     [
#       [0,0,0],
#       [0,0,0],
#       [0,0,0]
#     ],
#     [
#       [0,0,0],
#       [0,0,0],
#       [0,0,0]
#     ]
#   ]
# end

# let(:test_mappings) do
#   [
#     {
#       input: [
#         [0,0,0],
#         [0,1,0],
#         [0,0,0]
#       ],
#       output: [
#         [0,0,0],
#         [0,0,0],
#         [0,0,0]
#       ]
#     },
#     {
#       input: [
#         [0,1,1],
#         [0,1,0],
#         [0,0,0]
#       ],
#       output: [
#         [0,1,0],
#         [0,0,0],
#         [0,0,0]
#       ]
#     }
#   ]
# end

# it "it dies as if by underpopulation" do
# outputs = input_states.map { |input_state| described_class.call(input_state, grid_width: grid_width, grid_height: grid_height) }
# expect(outputs).to eq(expected_states)

#     test_mappings.each do |test_mapping|
#       expect(described_class.call(test_mapping[:input], grid_width: grid_width, grid_height: grid_height)).to eq test_mapping[:output]
#     end
#   end
# end

# context "rule 2 - when there are 2 or 3 live neighbours" do
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
#   end
# end

# outside in:

describe GameOfLife do
  describe '#call' do
    subject(:call) { described_class.call(input_state, grid_width: grid_width, grid_height: grid_height) }
    let(:grid_width) { 3 }
    let(:grid_height) { 3 }

    context 'rule 1 - when a live cell has fewer than two live neighbours' do
      let(:input_state) do
        [
          [0, 0, 0],
          [0, 1, 0],
          [0, 0, 0]
        ]
      end

      it 'dies as if by underpopulation' do
        expected_state = [
          [0, 0, 0],
          [0, 0, 0],
          [0, 0, 0]
        ]
        expect(call).to eq(expected_state)
      end
    end

    context 'rule 2 - when a live cell has two or three live neighbours' do
      let(:input_states) do
        [
          [
            [0, 1, 0],
            [0, 1, 0],
            [0, 0, 0]
          ],
          [
            [0, 1, 0],
            [0, 1, 1],
            [0, 0, 0]
          ],
          [
            [0, 1, 1],
            [0, 1, 1],
            [0, 0, 0]
          ]
        ]
      end
      let(:expected_states) do
        [
          [
            [0, 1, 0],
            [0, 1, 0],
            [0, 0, 0]
          ],
          [
            [0, 1, 0],
            [0, 1, 1],
            [0, 0, 0]
          ],
          [
            [0, 1, 1],
            [0, 1, 1],
            [0, 0, 0]
          ]
        ]
      end

      it 'lives on to the next generation' do
        output = input_states.map do |input|
          described_class.call(input, grid_width: grid_width, grid_height: grid_height)
        end

        expect(output).to eq(:expected_states)
      end
    end

    context 'rule 3 - when a live cell has more than 3 live neighbours' do
      let(:input_states) do
        [
          [
            [1, 1, 0],
            [1, 1, 0],
            [0, 0, 0]
          ],
          [
            [1, 1, 1],
            [1, 1, 1],
            [1, 1, 1]
          ],
          [
            [1, 1, 0],
            [1, 1, 1],
            [0, 0, 0]
          ]
        ]
      end
      let(:expected_states) do
        [
          [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0]
          ],
          [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0]
          ],
          [
            [0, 0, 0],
            [0, 0, 1],
            [0, 0, 0]
          ]
        ]
      end

      it 'dies as if by overpopulation' do
        output = input_states.map do |input|
          described_class.call(input, grid_width: grid_width, grid_height: grid_height)
        end

        expect(output).to eq(:expected_states)
      end
    end

    context 'rule 4 - a dead cell has exactly 3 live neighbours' do
      let(:input_states) do
        [
          [
            [1, 1, 0],
            [1, 0, 0],
            [0, 0, 0]
          ],
          [
            [0, 1, 0],
            [1, 0, 1],
            [0, 0, 0]
          ],
          [
            [1, 1, 1],
            [1, 0, 0],
            [0, 0, 0]
          ]
        ]
      end
      let(:expected_states) do
        [
          [
            [1, 1, 0],
            [1, 1, 0],
            [0, 0, 0]
          ],
          [
            [0, 1, 0],
            [1, 1, 1],
            [0, 0, 0]
          ],
          [
            [1, 1, 0],
            [1, 0, 0],
            [0, 0, 0]
          ]
        ]
      end
      it 'becomes a live cell as if by reproduction' do
        output = input_states.map do |input|
          described_class.call(input, grid_width: grid_width, grid_height: grid_height)
        end

        expect(output).to eq(:expected_states)
      end
    end

    context 'When a block of 4 come together' do
      let(:start_state) do
        [
          [
            [0, 0, 0, 0],
            [0, 1, 1, 0],
            [0, 1, 1, 0],
            [0, 0, 0, 0]
          ]
        ]
      end
      it 'stays the same' do
        output = described_class.call(start_state, grid_width: 4, grid_height: 4)

        expect(output).to eq(start_state)
      end
    end

    context 'When a line of three come together' do
      let(:start_state) do
        [
          [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 1, 1, 1, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ]
        ]
      end
      let(:expected_state) do
        [
          [
            [0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0]
          ]
        ]
      end
      it 'should rotate 90 degrees' do
        output = described_class.call(start_state, grid_width: 5, grid_height: 5)

        expect(output).to eq(expected_state)
      end
      it 'should return to the start position after 2 calls' do
        output = 2.times.reduce(start_state) do | state, index | 
          state = described_class.call(start_state, grid_width: 5, grid_height: 5)
        end

        expect(output).to eq(start_state)
      end
    end
  end
end

# inside out:

# describe GameOfLife do
#   describe '#rule1' do
#     subject(:call) { described_class.rule1(node_coordinate, state) }
#     let(:state) do
#       [
#         [0, 0, 0],
#         [0, 1, 0],
#         [0, 0, 0]
#       ]
#     end

#     context 'when a specified node 1,1 has fewer than 2 neighbours' do
#       let(:node_coordinate) { [1, 1] }

#       it 'returns false' do
#         expect(call).to eq(false)
#       end
#     end

#     context 'when a specified node 1,0 has fewer than 2 neighbours' do
#       let(:node_coordinate) { [1, 0] }

#       it 'returns false' do
#         expect(call).to eq(false)
#       end
#     end

#     context 'when a specified node has 2 neighbours' do
#       let(:state) do
#         [
#           [0, 0, 0],
#           [1, 1, 1],
#           [0, 0, 0]
#         ]
#       end
#       let(:node_coordinate) { [1, 1] }

#       it 'returns true' do
#         expect(call).to eq(true)
#       end
#     end
#   end

#   describe '#rule2 is not worth evaluating' do
#     subject(:call) { described_class.rule2(node_coordinate, state) }
#     let(:state) do
#       [
#         [0, 1, 1],
#         [1, 1, 0],
#         [0, 0, 1]
#       ]
#     end

#     context 'when a specified node 1,1 has fewer than 2 neighbours' do
#       let(:node_coordinate) { [3, 3] }

#       it 'returns false' do
#         expect(call).to eq(false)
#       end
#     end

#     context 'when a specified node 1,1 has 2 neighbours' do
#       let(:node_coordinate) { [1, 2] }

#       it 'returns true' do
#         expect(call).to eq(true)
#       end
#     end
#   end
#     context 'when a specified node 1,1 has 3 neighbours' do
#       let(:node_coordinate) { [3, 3] }

#       it 'returns true' do
#         expect(call).to eq(true)
#       end
#     end

#     context 'when a specified node 1,1 has more than 3 neighbours' do
#       let(:node_coordinate) { [1, 2] }

#       it 'returns false' do
#         expect(call).to eq(false)
#       end
#     end
#   end

#   describe '#rule3' do
#     subject(:call) { described_class.rule3(input_state, grid_width: grid_width, grid_height: grid_height) }
#     let(:grid_width) { 3 }
#     let(:grid_height) { 3 }

#     context 'when X context' do
#     end
#   end

#   describe '#rule4' do
#     subject(:call) { described_class.rule4(input_state, grid_width: grid_width, grid_height: grid_height) }
#     let(:grid_width) { 3 }
#     let(:grid_height) { 3 }

#     context 'when X context' do
#     end
#   end

#   describe '#call' do
#     subject(:call) { described_class.call(input_state, grid_width: grid_width, grid_height: grid_height, rules: []) }
#     let(:rules) { [true, false, true, false] }
#     let(:grid_width) { 3 }
#     let(:grid_height) { 3 }

#     context 'when rule_1 and rule_2 is true, and rule_3 and rule_4 is false'
#     it 'returns correct result' do
#       let(:test_mappings) do
#         [
#           {
#             input: [
#               [0, 0, 0],
#               [0, 1, 0],
#               [0, 0, 0]
#             ],
#             output: [
#               [0, 0, 0],
#               [0, 0, 0],
#               [0, 0, 0]
#             ]
#           },
#           {
#             input: [
#               [0, 1, 1],
#               [0, 1, 0],
#               [0, 0, 0]
#             ],
#             output: [
#               [0, 1, 0],
#               [0, 0, 0],
#               [0, 0, 0]
#             ]
#           }
#         ]
#       end

#       # assert
#     end
#   end
# end
