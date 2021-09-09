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

    return true if row < grid.size &&
                   column < grid.first.size &&
                   row >= 0 &&
                   column >= 0

    puts 'Selection out of range'
    false
  end

  # chess notation to grid co-ordinates
  def coords(pos)
    col = (pos[0].downcase.ord - 'a'.ord)
    row = 8 - pos[1].to_i
    [row, col]
  end

  def player_move(player, board)
    move_from = []
    move_to = []

    puts "#{player.color.capitalize}'s move"

    loop do
      move_from = player_input('Select piece to move')
      break if validate_move(move_from, board, player, 'start')
    end

    move_to = player_input('Select position to move to')
    move_piece(move_from, move_to, board)
  end

  def move_piece(move_from, move_to, board)
    board[move_to] = board[move_from]
    board[move_from] = EMPTY_POS
  end

  def validate_move(move, board, player, start_end)
    if board[move].is_a?(Piece) && board[move].color == player.color && start_end == 'start'
      true
    else
      puts "Invalid move. Please select a #{player.color} piece to move"
      false
    end
  end

  def player_input(msg)
    loop do
      puts msg
      input = coords(gets.chomp)
      return input if in_bounds?(input)
    end
  end
end
