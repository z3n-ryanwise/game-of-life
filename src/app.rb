require 'ruby2d'

COLOUR_CELL = 'blue'
COLOUR_GRID = 'green'
COLOUR_BACKGROUND = 'black'

set title: 'Game of life'
set background: COLOUR_BACKGROUND


CELL_SIZE = 60
CELL_STATE = {}
WINDOW_WIDTH = CELL_SIZE * 20
WINDOW_HEIGHT = CELL_SIZE * 20

set width: WINDOW_WIDTH
set height: WINDOW_HEIGHT

# Draw the vertical lines for the grid
(WINDOW_WIDTH / CELL_SIZE).times do |n|
  Line.new(
    x1: n * CELL_SIZE, y1: 0,
    x2: n * CELL_SIZE, y2: WINDOW_HEIGHT,
    width: 1,
    color: COLOUR_GRID
  )
end

# Draw the horizontal lines for the grid
(WINDOW_WIDTH / CELL_SIZE).times do |n|
  Line.new(
    x1: 0, y1: n * CELL_SIZE,
    x2: WINDOW_WIDTH, y2: n * CELL_SIZE,
    width: 1,
    color: COLOUR_GRID
  )
end

def render_cell(x, y)
  return if CELL_STATE["#{x},#{y}"].is_a?(Square)

  new_shape = Square.new(
    x: x, y: y,
    size: CELL_SIZE,
    color: COLOUR_CELL,
    z: -10
  )
  CELL_STATE["#{x},#{y}"] = new_shape
end

def remove_cell(x, y)
  drawn_cell = CELL_STATE["#{x},#{y}"]
  drawn_cell.remove
  CELL_STATE["#{x},#{y}"] = nil
  CELL_STATE.compact!
end

tick = 0
update do
  if tick % 120 == 0
    CELL_STATE.clone.each_value do |shape|

      render_cell(shape.x + CELL_SIZE, shape.y)
      render_cell(shape.x - CELL_SIZE, shape.y)
      render_cell(shape.x, shape.y + CELL_SIZE)
      render_cell(shape.x, shape.y - CELL_SIZE)

      # current_state = CELL_STATE
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

on :mouse_down do |event|
  vector_x = event.x - (event.x % CELL_SIZE)
  vector_y = event.y - (event.y % CELL_SIZE)

  p 'MOUSE DOWN EVENT!'
  p vector_x, vector_y

  drawn_cell = CELL_STATE["#{vector_x},#{vector_y}"]

  p "drawn cell exist?: #{!drawn_cell.nil?}"

  if drawn_cell
    p "removing cell"
    remove_cell(vector_x, vector_y)
  else
    p "drawing cell"
    render_cell(vector_x, vector_y)
  end
end

show
