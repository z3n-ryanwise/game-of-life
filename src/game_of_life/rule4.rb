module GameOfLife
  class Rule4
    def self.call(input_state, coord)
      row_position = coord[0]
      col_position = coord[1]

      return NOOP_STATE if input_state[row_position][col_position] == 1

      width = input_state[col_position].size
      height = input_state.size

      left_neighbour = input_state[row_position][col_position - 1]
      right_neighbour = input_state[row_position][(col_position + 1) % width]

      up_neighbour = input_state[row_position - 1][col_position]
      down_neighbour = input_state[(row_position + 1) % height][col_position]

      up_left_neighbour = input_state[row_position - 1][col_position - 1]
      up_right_neighbour = input_state[row_position - 1][(col_position + 1) % width]

      down_left_neighbour = input_state[(row_position + 1) % height][col_position - 1]
      down_right_neighbour = input_state[(row_position + 1) % height][(col_position + 1) % width]

      neighbour_count = [left_neighbour, right_neighbour, up_neighbour, down_neighbour, up_left_neighbour,
                         up_right_neighbour, down_left_neighbour, down_right_neighbour].inject(&:+)

      neighbour_count == 3 ? ALIVE_STATE : NOOP_STATE
    end
  end
end
