# methods for movement of pieces
module BoardMovement
  # moves piece on board
  def move_piece(move_from, move_to, board)
    board[move_to] = board[move_from]
    board[move_from] = EMPTY_POS
    board[move_to].moved = true
  end

  # validates selection of correct piece
  def validate_move(move_from, move_to, board, player, piece, start_end)
    case start_end
    when 'start'
      check_start(move_from, board, player)
    when 'end'
      check_end(move_from, move_to, board, player, piece)
    end
  end

  def check_start(move, board, player)
    if board[move].is_a?(Piece) && board[move].color == player.color
      true
    else
      puts "Invalid move #{notation(move)}.  Please select a #{player.color} piece"
      false
    end
  end

  def check_end(move_from, move_to, board, _player, piece)
    valid_moves = valid_moves(move_from, board, piece)
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

  def valid_moves(pos, board, piece)
    piece_type = piece.type
    moved = piece.moved

    pawn_moves_white = [-1, 0]
    pawn_moves_black = [1, 0]
    pawn_capture_white = [[-1, -1], [-1, 1]]
    pawn_capture_black = [[1, -1], [1, 1]]

    rook_moves = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    bishop_moves = [[1, -1], [1, 1], [-1, -1], [-1, 1]]
    knight_moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    queen_moves = rook_moves + bishop_moves

    case piece_type
    when :rook
      possible_moves = sliding_moves(board, rook_moves, pos)
    when :bishop
      possible_moves = sliding_moves(board, bishop_moves, pos)
    when :queen
      possible_moves = sliding_moves(board, queen_moves, pos)
    when :knight
      possible_moves = single_move(board, knight_moves, pos)
    when :king
      possible_moves = single_move(board, queen_moves, pos)
    when :pawn
      possible_moves = if piece.color == :white
                         pawn_moves(board, pawn_moves_white, pawn_capture_white, pos, moved)
                       else
                         pawn_moves(board, pawn_moves_black, pawn_capture_black, pos, moved)
                       end
    end
    possible_moves
  end

  def sliding_moves(board, moves, pos, possible_moves = [])
    org_pos = pos
    moves.each do |move|
      loop do
        move_step = [pos, move].transpose.map(&:sum)
        if !in_bounds?(move_step)
          pos = org_pos
          break
        elsif board[move_step].is_a?(Piece)
          possible_moves << move_step
          break
        end
        possible_moves << move_step
        pos = move_step
      end
    end
    possible_moves
  end

  def single_move(board, moves, pos, possible_moves = [])
    moves.each do |move|
      move_step = [pos, move].transpose.map(&:sum)
      possible_moves << move_step if (in_bounds?(move_step) &&
                                     board[move_step] == EMPTY_POS) ||
                                     (in_bounds?(move_step) &&
                                      board[move_step].color != board[pos].color)
    end
    possible_moves
  end

  def pawn_moves(board, moves, capture_moves, pos, moved, possible_moves = [])
    capture_moves.each do |move|
      move_step = [pos, move].transpose.map(&:sum)
      possible_moves << move_step if in_bounds?(move_step) &&
                                     board[move_step] != EMPTY_POS &&
                                     board[move_step].color != board[pos].color
    end

    2.times do
      move_step = [pos, moves].transpose.map(&:sum)
      break if !in_bounds?(move_step) || board[move_step].is_a?(Piece)

      possible_moves << move_step
      break if moved == true

      pos = move_step
    end

    possible_moves
  end
end
