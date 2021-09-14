require_relative 'board'
require_relative 'piece'
require_relative 'renderer'
require_relative 'player'

# controls the flow of the game
class Chess
  attr_reader :current_player, :board

  def initialize
    # setup new board
    @board = Board.new

    # setup the players
    @player_white = Player.new('Player_1', :white, @board)
    @player_black = Player.new('Player_2', :black, @board)

    # get player names
    # player_names

    # assign current player
    @current_player = @player_white
  end

  def play
    new_game
    loop do
      board.player_move(current_player, board)
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

end
