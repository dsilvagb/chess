# frozen_string_literal: true

require_relative 'movement'
require_relative 'check'
require_relative 'string'

# empty squares on grid
EMPTY_POS = ' '

# sets up the a 8 x 8 array to represent the squares
# on the chess board
class Board
  include BoardMovement
  include CheckMate

  attr_accessor :grid

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

  # player piece selection and validates moves
  def player_move(player, move_from = [], move_to = [])
    king_check?(player.color)
    puts "#{player.color.capitalize}'s move"

    loop do
      move_from = player_input('Select piece to move')
      move_to = player_input('Select position to move to')
      piece = self[move_from]
      break if validate_move(move_from, move_to, player, piece, 'start') &&
               validate_move(move_from, move_to, player, piece, 'end') &&
               self_check?(player.color, move_from, move_to) == false
    end
  end

  # player input and range check
  def player_input(msg)
    loop do
      puts msg
      input = gets.chomp
      input == '' ? next : input = coords(input)

      in_bounds?(input) ? (return input) : (puts 'Selection out of range'.red)
    end
  end

  # moves piece on board
  def move_piece(move_from, move_to)
    self[move_to] = self[move_from]
    self[move_from] = EMPTY_POS
    self[move_to].moved = true
  end

  # validates selection of correct piece
  def validate_move(move_from, move_to, player, piece, start_end)
    case start_end
    when 'start'
      validate_start(move_from, player)
    when 'end'
      validate_end(move_from, move_to, piece)
    end
  end

  # validates the square selected has a piece of correct color
  def validate_start(move, player)
    if self[move].is_a?(Piece) && self[move].color == player.color
      true
    else
      puts "Invalid move #{notation(move)}.  Please select a #{player.color} piece"
      false
    end
  end

  # validates that the position piece is moved to is valid
  def validate_end(move_from, move_to, piece)
    valid_moves = valid_moves(move_from, piece)
    if valid_moves.include?(move_to)
      true
    elsif valid_moves == []
      puts "No valid moves for piece at #{notation(move_from)}".red
    else
      puts "Invalid move #{notation(move_to)}. Valid moves".red
      valid_moves.each { |e| puts notation(e) }
      puts ''
      false
    end
  end
end
