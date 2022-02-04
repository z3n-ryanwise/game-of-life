require 'ruby2d'

set title: "Game of life"
set background: "white"

CELL_SIZE = 60
WINDOW_WIDTH = CELL_SIZE * 20
WINDOW_HEIGHT = CELL_SIZE * 20

set width: WINDOW_WIDTH
set height: WINDOW_HEIGHT

# Draw the vertical lines for the grid
(WINDOW_WIDTH/CELL_SIZE).times do |n|
  Line.new(
    x1: n * CELL_SIZE, y1: 0,
    x2: n * CELL_SIZE, y2: WINDOW_HEIGHT,
    width: 1,
    color: 'black',
  )
end

# Draw the horizontal lines for the grid
(WINDOW_WIDTH/CELL_SIZE).times do |n|
  Line.new(
    x1: 0, y1: n * CELL_SIZE,
    x2: WINDOW_WIDTH, y2: n * CELL_SIZE,
    width: 1,
    color: 'black',
  )
end

cell_state = {}

tick = 0
update do
  if tick % 120 == 0
    cell_state.compact!
    p "cell_state"
    p cell_state

    cell_state.values.each do |shape|
      p "shape"
      p shape
      # if drawn_cell
        shape.remove
        cell_state["#{shape.x},#{shape.y}"] = nil

        new_shape = Square.new(
          x: shape.x + CELL_SIZE, y: shape.y,
          size: CELL_SIZE,
          color: 'blue',
          z: -10
        )
        cell_state["#{shape.x + CELL_SIZE},#{shape.y}"] = new_shape

        new_shape = Square.new(
          x: shape.x, y: shape.y + CELL_SIZE,
          size: CELL_SIZE,
          color: 'blue',
          z: -10
        )
        cell_state["#{shape.x},#{shape.y + CELL_SIZE}"] = new_shape
      # end
    end
  end
  tick += 1
end


on :mouse_down do |event|
  vector_x = event.x - (event.x % CELL_SIZE)
  vector_y = event.y - (event.y % CELL_SIZE)

  p "MOUSE DOWN EVENT!"
  p vector_x, vector_y

  drawn_cell = cell_state["#{vector_x},#{vector_y}"]

  p "drawn cell exist?: #{!drawn_cell.nil?}"

  if drawn_cell
    p "removing drawn cell"
    drawn_cell.remove
    cell_state["#{vector_x},#{vector_y}"] = nil
    cell_state.compact!
    
    p "#### cell_state after deletion"
    p cell_state
  else
    new_shape = Square.new(
      x: vector_x, y:vector_y,
      size: CELL_SIZE,
      color: 'blue',
      z: 10
    )
    cell_state["#{vector_x},#{vector_y}"] = new_shape
  end
end

show