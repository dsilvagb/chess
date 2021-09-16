# frozen_string_literal: true

require_relative 'string'

# renders the board and displays the pieces
class Renderer
  # render board with notations
  def render_board(grid)
    puts "\e[H\e[2J"
    puts "\n+-------------------------------+"
    # loop through data structure
    grid.each_with_index do |row_val, row|
      print '| '
      row_val.each_with_index do |_col_val, col|
        # display an existing piece if any, else blank
        s = grid[row][col]
        print s
        print ' | '
        print " #{8 - row} " if col == 7
      end
      puts "\n+-------------------------------+"
    end
    puts '  A   B   C   D   E   F   G   H '
    puts ' '
  end

  # populate pieces for new game
  def new_game(board)
    (0..7).each do |col|
      board[[1, col]] = Piece.new(:pawn, :black)
      board[[6, col]] = Piece.new(:pawn, :white)
    end

    board[[0, 0]] = Piece.new(:rook, :black)
    board[[0, 1]] = Piece.new(:knight, :black)
    board[[0, 2]] = Piece.new(:bishop, :black)
    board[[0, 3]] = Piece.new(:queen, :black)
    board[[0, 4]] = Piece.new(:king, :black)
    board[[0, 5]] = Piece.new(:bishop, :black)
    board[[0, 6]] = Piece.new(:knight, :black)
    board[[0, 7]] = Piece.new(:rook, :black)

    board[[7, 0]] = Piece.new(:rook, :white)
    board[[7, 1]] = Piece.new(:knight, :white)
    board[[7, 2]] = Piece.new(:bishop, :white)
    board[[7, 3]] = Piece.new(:queen, :white)
    board[[7, 4]] = Piece.new(:king, :white)
    board[[7, 5]] = Piece.new(:bishop, :white)
    board[[7, 6]] = Piece.new(:knight, :white)
    board[[7, 7]] = Piece.new(:rook, :white)

    render_board(board.grid)
  end
end
