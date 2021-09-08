# frozen_string_literal: true
require_relative 'string'

# sets up the pieces with color and type
class Piece
  attr_reader :type, :color, :moved

  def initialize(type, color, moved = false)
    @type = type
    @color = color
    @moved = moved
  end

  # assigns the symbols to be rendered on the board
  def to_s
    s = if type == :knight
          'n'
        else
          type.to_s[0, 1]
        end
    color == :black ? s.downcase.bold : s.upcase
  end
end
