module GameOfLife
  require_relative './rule1'
  require_relative './rule2'
  require_relative './rule3'
  require_relative './rule4'

  NOOP_STATE = 0
  DEAD_STATE = -1
  ALIVE_STATE = 1

  class Main
    DEFAULT_RULES = [
      GameOfLife::Rule1,
      GameOfLife::Rule2,
      GameOfLife::Rule3,
      GameOfLife::Rule4
    ]
    def self.call(input_state, rules = DEFAULT_RULES)
      alive_count = input_state.map { |row| row.map { |_| 0 } }

      rules.each do |rule|
        input_state.each_with_index.map do |row, row_position|
          row.each_with_index.map do |_cell, col_position|
            rule_eval = rule.call(input_state, [row_position, col_position])

            case rule_eval
            when DEAD_STATE
              alive_count[row_position][col_position] -= 1
            when ALIVE_STATE
              alive_count[row_position][col_position] += 1
            end
          end
        end
        # puts '---------'
        # puts "After Rule Eval #{rule}"
        # puts 'input_state'
        # pp input_state
        # puts 'alive_count'
        # pp alive_count
        # puts '---------'
      end

      # pp alive_count

      input_state.each_with_index.map do |row, row_position|
        row.each_with_index.map do |_cell, col_position|
          if alive_count[row_position][col_position].negative?
            0
          elsif alive_count[row_position][col_position].positive?
            1
          else
            input_state[row_position][col_position]
          end
        end
      end

      # p 'result'
      # pp result
    end
  end
end
