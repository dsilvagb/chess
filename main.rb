require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/piece'
require_relative 'lib/renderer'
require_relative 'lib/player'

chess = Chess.new
chess.play

# board = Board.new
# render = Renderer.new
# @player_white = Player.new('Player_1', :white, @board)
# @player_black = Player.new('Player_2', :black, @board)
# current_player = @player_white

# =begin # chess notation to grid co-ordinates
# def coords(pos)
#   col = (pos[0].downcase.ord - 'a'.ord)
#   row = 8 - pos[1].to_i
#   [row, col]
# end

# def notation(pos)
#   col = (pos[1] + 'a'.ord).chr
#   row = 8 - pos[0]
#   col + row.to_s
# end

# def valid_moves(pos, board)
#   # pawn_moves = [[-1, 0], [-2, 0]]
#   possible_moves = []
#   org_pos = pos
#   # pawn_moves.each do |move|
#   #   possible_moves << [pos, move].transpose.map(&:sum)
#   # end
#   # possible_moves

#   vertical_moves = [[1, 0], [-1, 0]]
#   horizontal_moves = [[0, 1], [0, -1]]
#   diagonal_moves = [[1, -1], [1, 1], [-1, -1], [-1, 1]]
#   queen_moves = vertical_moves + horizontal_moves + diagonal_moves

#   queen_moves.each do |move|
#     loop do
#       move_step = [pos, move].transpose.map(&:sum)
#       if !move_step[0].between?(0, 7) || !move_step[1].between?(0, 7) || board[move_step].is_a?(Piece)
#         pos = org_pos
#         break
#       end
#       possible_moves << move_step
#       pos = move_step
#     end
#   end
#   possible_moves
# end

# render.new_game(board)

# render.render_board(board.grid)

# puts valid_moves(coords('d1'), board)

# possible_moves = valid_moves(coords('d2'), board)
# possible_moves.each { |move| puts notation(move) }
#  =end