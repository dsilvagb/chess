# frozen_string_literal: true

require_relative 'movement'
require_relative 'string'

# empty squares on grid
EMPTY_POS = ' '

# sets up the a 8 x 8 array to represent the squares
# on the chess board
class Board
  include BoardMovement

  attr_reader :grid

  def initialize(board_size = 8)
    @grid = Array.new(board_size) { Array.new(board_size) { EMPTY_POS } }
  end

  # override array to allow placement of piece on grid
  def []=(location, piece)
    row, column = location
    grid[row][column] = piece
  end

  # override array to allow grid location to be called directly
  def [](location)
    row, column = location
    grid[row][column]
  end

  # validate if location is on board
  def in_bounds?(location)
    row, column = location

    return true if row < grid.size &&
                   column < grid.first.size &&
                   row >= 0 &&
                   column >= 0

    false
  end

  # chess notation to grid co-ordinates
  def coords(pos)
    col = (pos[0].downcase.ord - 'a'.ord)
    row = 8 - pos[1].to_i
    [row, col]
  end

  # grid co-ordinates to chess notation
  def notation(pos)
    col = (pos[1] + 'a'.ord).chr
    row = 8 - pos[0]
    col + row.to_s
  end

  # for for move and validates
  def player_move(player, move_from = [], move_to = [])
    puts "#{player.color.capitalize}'s move"

    loop do
      move_from = player_input('Select piece to move')
      move_to = player_input('Select position to move to')
      piece = self[move_from]
      break if validate_move(move_from, move_to, player, piece, 'start') &&
               validate_move(move_from, move_to, player, piece, 'end')
    end

    move_piece(move_from, move_to)
  end

  # player input and range check
  def player_input(msg)
    loop do
      puts msg
      input = coords(gets.chomp)
      in_bounds?(input) ? (return input) : (puts 'Selection out of range'.red)
    end
  end
end
