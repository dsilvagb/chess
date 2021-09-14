# frozen_string_literal: true

# methods for movement of pieces
module BoardMovement
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
      check_start(move_from, player)
    when 'end'
      check_end(move_from, move_to, piece)
    end
  end

  def check_start(move, player)
    if self[move].is_a?(Piece) && self[move].color == player.color
      true
    else
      puts "Invalid move #{notation(move)}.  Please select a #{player.color} piece"
      false
    end
  end

  def check_end(move_from, move_to, piece)
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

  def valid_moves(pos, piece)
    piece_type = piece.type

    moves = { pawn_white: [-1, 0],
              pawn_black: [1, 0],
              pawn_capture_white: [[-1, -1], [-1, 1]],
              pawn_capture_black: [[1, -1], [1, 1]],
              rook: [[1, 0], [-1, 0], [0, 1], [0, -1]],
              bishop: [[1, -1], [1, 1], [-1, -1], [-1, 1]],
              knight: [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]] }
    moves[:queen] = moves[:rook] + moves[:bishop]
    moves[:king] = moves[:queen]

    if %i[rook bishop queen].include?(piece_type)
      possible_moves = sliding_moves(moves[piece_type], pos)
    elsif %i[knight king].include?(piece_type)
      possible_moves = single_move(moves[piece_type], pos)
    elsif piece_type == :pawn
      possible_moves = if piece.color == :white
                         pawn_moves(moves[:pawn_white], moves[:pawn_capture_white], pos)
                       else
                         pawn_moves(moves[:pawn_black], moves[:pawn_capture_black], pos)
                       end
    end
    possible_moves
  end

  def sliding_moves(moves, pos, possible_moves = [])
    org_pos = pos
    moves.each do |move|
      loop do
        move_step = [pos, move].transpose.map(&:sum)
        if !in_bounds?(move_step)
          pos = org_pos
          break
        elsif self[move_step].is_a?(Piece)
          possible_moves << move_step
          break
        end
        possible_moves << move_step
        pos = move_step
      end
    end
    possible_moves
  end

  def single_move(moves, pos, possible_moves = [])
    moves.each do |move|
      move_step = [pos, move].transpose.map(&:sum)
      possible_moves << move_step if (in_bounds?(move_step) &&
                                     self[move_step] == EMPTY_POS) ||
                                     (in_bounds?(move_step) &&
                                      self[move_step].color != self[pos].color)
    end
    possible_moves
  end

  def pawn_moves(moves, capture_moves, pos, possible_moves = [])
    moved = self[pos].moved

    possible_moves = pawn_capture(capture_moves, pos, possible_moves)

    2.times do
      move_step = [pos, moves].transpose.map(&:sum)
      break if !in_bounds?(move_step) || self[move_step].is_a?(Piece)

      possible_moves << move_step
      break if moved == true

      pos = move_step
    end

    possible_moves
  end

  def pawn_capture(capture_moves, pos, possible_moves)
    capture_moves.each do |move|
      move_step = [pos, move].transpose.map(&:sum)
      possible_moves << move_step if in_bounds?(move_step) &&
                                     self[move_step] != EMPTY_POS &&
                                     self[move_step].color != self[pos].color
    end
    possible_moves
  end
end
