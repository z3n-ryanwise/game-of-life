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

show