module GameOfLife
  class Main
    DEFAULT_RULES = [
      GameOfLife::Rule1
      GameOfLife::Rule2
      GameOfLife::Rule3
      GameOfLife::Rule4
      
    ]
    def self.call(input_state, rules=DEFAULT_RULES)
      
      # state = input_state.rule1
      # state = state.rule2
      # state = state.rule3
      # state = state.rule4

      input_state.map do |row|
        row.map do |cell|
          rules[0].call(cell) ? 1 : 0
        end
      end

      state 
    end
  end
end


GameOfLife::Main.call(state State, [GameOfLife::Rule1, GameOfLife::Rule2] []{call: boolean})



lambda.call
GameOfLife::Rule1.calli