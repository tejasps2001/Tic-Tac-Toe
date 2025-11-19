# frozen_string_literal: true

# Player class
class Player
  attr_accessor :name, :symbol

  def initialize
    @symbol = nil
  end

  def input_name
    puts "What's your name, Player? "
    @name = gets.chomp
  end

  def input_choice
    puts "Do you want X or O, #{@name}?"
    gets.chomp
  end

  def input_symbol
    loop do
      choice = input_choice
      case choice
      when 'X', 'O'
        @symbol = choice
        return @symbol
      else
        puts "Wrong input. Try again!\n"
      end
    end
  end

  def choose_symbol(symbols)
    # If called by the second player, choose the one that is left in the symbols array automatically
    if symbols.length == 1
      @symbol = symbols[0]
      return @symbol
    end
    @symbol = input_symbol
  end

  def get_move(game, available_moves)
    move = -1
    loop do
      puts "#{@name}'s move: "
      move = gets.chomp.to_i
      break if available_moves.include?(move)

      puts "Invalid move! Try again.\n"
      game.list_available_moves
      puts "\n"
    end
    move
  end
end
