require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/piece'
require_relative 'lib/renderer'
require_relative 'lib/player'


chess = Chess.new
chess.play

# board = Board.new
# render = Renderer.new


# # chess notation to grid co-ordinates
# def coords(pos)
#   col = (pos[0].downcase.ord - 'a'.ord)
#   row = 8 - pos[1].to_i
#   [row, col]
# end

# render.new_game(board)

# loop do
#   puts "#{}"
#   puts 'move from'
#   move_from = coords('a2')
#   move_to = coords('a4')
# end



# board[move_to] = board[move_from]
# board[move_from] = EMPTY_POS

# render.render_board(board.grid)