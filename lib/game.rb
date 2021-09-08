require_relative 'board'
require_relative 'piece'
require_relative 'renderer'
require_relative 'player'

class Chess
  attr_reader :current_player, :board

  def initialize
    # setup new board
    @board = Board.new

    # setup the players
    @player_white = Player.new('Player_1', :white, @board)
    @player_black = Player.new('Player_2', :black, @board)

    # get player names
    player_names

    # assign current player
    @current_player = @player_white
  end

  def play
    new_game
    loop do
      puts "#{current_player.color}'s move"
      puts 'Select piece to move'
      move_from = coords(gets.chomp)
      puts 'Select position to move to'
      move_to = coords(gets.chomp)

      board[move_to] = board[move_from]
      board[move_from] = EMPTY_POS

      switch_current_player(current_player)
      @render.render_board(board.grid)
    end
  end

  def new_game
    @render = Renderer.new
    @render.new_game(board)
  end

  # assign player names
  def player_names
    @player_white.update_player_name(@player_white)
    @player_black.update_player_name(@player_black)
  end

  def switch_current_player(player)
    @current_player = player == @player_white ? @player_black : @player_white
  end

  # chess notation to grid co-ordinates
  def coords(pos)
    col = (pos[0].ord - 'a'.ord)
    row = 8 - pos[1].to_i
    [row, col]
  end
end
