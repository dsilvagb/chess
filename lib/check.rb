# frozen_string_literal: true

# module for check and check mate
module CheckMate
  # verify if check or checkmate of oponent after move renders board
  def king_check?(color)
    piece_color = color == :white ? :black : :white
    king_position = king_position(color)
    possible_check(piece_color, king_position) ? true : (return false)
    if check_mate?(color)
      puts "Checkmate !!!!, #{piece_color} wins"
      exit!
    else
      puts 'Check !!!'.red
    end
    true
  end

  # verify if check of current player after move
  # rollback move if check
  def self_check?(color, move_from, move_to)
    piece_color = color == :white ? :black : :white
    grid_org = Marshal.load(Marshal.dump(grid))
    move_piece(move_from, move_to)
    if possible_check(piece_color, king_position(color))
      puts "Invalid move.  Move results in check of #{color} king"
      rollback(grid_org)
      true
    else
      false
    end
  end

  # king position
  def king_position(color)
    king_pos = []
    grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, piece_index|
        king_pos = [row_index, piece_index] if piece.is_a?(Piece) &&
                                               piece.type == :king &&
                                               piece.color == color
      end
    end
    king_pos
  end

  # possible check after move
  def possible_check(color, king_pos)
    grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, piece_index|
        pos = [row_index, piece_index]
        if piece.is_a?(Piece) && piece.color == color
          valid_moves = valid_moves(pos, piece)
          return true if valid_moves.include? king_pos
        end
      end
    end
    false
  end

  # check mate
  def check_mate?(color)
    op_color = color == :white ? :black : :white
    grid_org = Marshal.load(Marshal.dump(grid))
    grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, piece_index|
        pos = [row_index, piece_index]
        next unless piece.is_a?(Piece) && piece.color == color

        valid_moves = valid_moves(pos, piece)
        valid_moves.each do |move|
          move_piece(pos, move)
          king_pos = king_position(color)
          check = possible_check(op_color, king_pos)
          rollback(grid_org)
          return false unless check
        end
      end
    end
    true
  end

  # roll back if check on current move
  def rollback(grid_org)
    grid.each_with_index do |row, row_index|
      row.each_with_index do |_col, col_index|
        grid[row_index][col_index] = grid_org[row_index][col_index]
      end
    end
  end
end
