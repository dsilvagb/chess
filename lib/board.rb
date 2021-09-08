# frozen_string_literal: true

EMPTY_POS = ' '

# sets up the a 8 x 8 array to represent the squares
# on the chess board
class Board
  attr_reader :grid

  def initialize(board_size = 8)
    @grid = Array.new(board_size) { Array.new(board_size) { EMPTY_POS } }
  end

  def []=(location, piece)
    row, column = location
    grid[row][column] = piece
  end

  def [](location)
    row, column = location
    grid[row][column]
  end

  def in_bounds?(location)
    row, column = location

    row < grid.size &&
      column < grid.first.size &&
      row >= 0 &&
      column >= 0
  end

end