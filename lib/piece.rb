# sets up the pieces with color and type
class Piece
  attr_reader :type, :color

  def initialize(type, color)
    @type = type
    @color = color
  end

  # assigns the symbols to be rendered on the board
  def to_s
    s = if type == :knight
          'n'
        else
          type.to_s[0, 1]
        end
    color == :black ? s.downcase : s.upcase
  end
end
