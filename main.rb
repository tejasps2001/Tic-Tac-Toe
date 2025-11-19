# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/player'

symbols = %w[X O]
player1 = Player.new
player2 = Player.new

# Get the names of the players
player1.input_name
player2.input_name

puts 'Welcome to Tic-Tac-Toe!'

# Players choose between 'X' and 'O'
player1.choose_symbol(symbols)
puts "#{player1.name} is #{player1.symbol}."
symbols.delete(player1.symbol)
player2.choose_symbol(symbols)
puts "#{player2.name} is #{player2.symbol}."

game = Game.new(player1, player2)
game.display

# Start game
while game.not_over?
  # Player 1's turn
  game.list_available_moves
  # Get all the option numbers of the available moves
  available_moves = game.output_available_moves
  move = player1.get_move(game, available_moves)
  game.make_move(player1, move)
  game.display
  result = game.over?
  if result == 1
    puts "#{player1.name} won!"
    break
  elsif result.zero?
    puts "It's a tie!"
    break
  end

  # Player 2's turn
  game.list_available_moves
  # Get all the option numbers of the available moves
  available_moves = game.output_available_moves
  move = player2.get_move(game, available_moves)
  game.make_move(player2, move)
  game.display
  result = game.over?
  if result == 2
    puts "#{player2.name} won!"
    break
  elsif result.zero?
    puts "It's a tie!"
    break
  end
end
