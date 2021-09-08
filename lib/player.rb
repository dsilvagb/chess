# frozen_string_literal: true

# class player for player functionality
class Player
  attr_accessor :name, :color

  # initalize name, piece and board
  def initialize(name, color, board)
    @name = name
    @color = color
    @board = board
  end

  # assigns player names
  def update_player_name(player)
    puts "\e[H\e[2J"
    puts "Name of #{player.name} playing with #{player.color}"
    name = gets.chomp
    @name = name
  end
end
