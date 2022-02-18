require 'ruby2d'

COLOUR_CELL = 'blue'
COLOUR_GRID = 'green'
COLOUR_BACKGROUND = 'black'

class Application
  def initialize
    @cell_state = {}
    @cell_size = 60
    @loop_interval = 120
    @window_width = @cell_size * 20
    @window_height = @cell_size * 20
  end

  def run
    Window.set title: 'Game of life'
    Window.set background: COLOUR_BACKGROUND
    Window.set width: @window_width
    Window.set height: @window_height

    pp "window: #{@window_width}"
    pp "cell_size: #{@cell_size}"
    # Draw the vertical lines for the grid
    (@window_width / @cell_size).times do |n|
      Line.new(
        x1: n * @cell_size, y1: 0,
        x2: n * @cell_size, y2: @window_height,
        width: 1,
        color: COLOUR_GRID
      )
    end

    # Draw the horizontal lines for the grid
    (@window_width / @cell_size).times do |n|
      Line.new(
        x1: 0, y1: n * @cell_size,
        x2: @window_width, y2: n * @cell_size,
        width: 1,
        color: COLOUR_GRID
      )
    end

    tick = 0
    Window.update do
      if tick % @loop_interval == 0
        @cell_state.clone.each_value do |shape|
          render_cell(shape.x + @cell_size, shape.y)
          render_cell(shape.x - @cell_size, shape.y)
          render_cell(shape.x, shape.y + @cell_size)
          render_cell(shape.x, shape.y - @cell_size)

          # current_state = @cell_state
          # {
          #   "60,60" => shape object
          # }

          # # translate state frm pixel coordinate to index coordinate
          # Option 1: { "60,60" => shape object } =>
          # * Option 2: [
          #   [0,0,0,0],
          #   [0,1,0,0],
          #   [0,0,0,0],
          #   [0,0,0,0]]

          # new_state = GameOfLife.call(current_state, grid_width, grid_height)
          # * Option 2: [[0,0,0,0], [0,1,0,0], [0,0,0,0], [0,0,0,0]]

          # some logic to add or remove based on the diff between current_state and new_state
        end
      end
      tick += 1
    end

    Window.on :mouse_down do |event|
      vector_x = event.x - (event.x % @cell_size)
      vector_y = event.y - (event.y % @cell_size)

      p 'MOUSE DOWN EVENT!'
      p vector_x, vector_y

      drawn_cell = @cell_state["#{vector_x},#{vector_y}"]

      p "drawn cell exist?: #{!drawn_cell.nil?}"

      if drawn_cell
        p 'removing cell'
        remove_cell(vector_x, vector_y)
      else
        p 'drawing cell'
        render_cell(vector_x, vector_y)
      end
    end

    Window.show
  end

  def render_cell(x, y)
    return if @cell_state["#{x},#{y}"].is_a?(Square)

    new_shape = Square.new(
      x: x, y: y,
      size: @cell_size,
      color: COLOUR_CELL,
      z: -10
    )
    @cell_state["#{x},#{y}"] = new_shape
  end

  def remove_cell(x, y)
    drawn_cell = @cell_state["#{x},#{y}"]
    drawn_cell.remove
    @cell_state["#{x},#{y}"] = nil
    @cell_state.compact!
  end
end

game = Application.new
game.run
