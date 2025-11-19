# frozen_string_literal: true

# Game class
class Game
  # Game status codes (stored in "status" variable)
  # -1 -> Game ongoing
  # 0 -> Draw
  # 1 -> Player 1 has won
  # 2 -> Player 2 has won

  # Each cell has
  # 0 -> Empty
  # 1 -> Player 1
  # 2 -> Player 2
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @status = -1
    # Internal representation of cells stored in .cells'
    @cells = [0] * 9 # Will have empty cells by default
    # External representation of cells stored in 'marks'
    @marks = [' '] * 9
    @moves = { 0 => 'Top left',
               1 => 'Top center',
               2 => 'Top right',
               3 => 'Middle left',
               4 => 'Middle center',
               5 => 'Middle right',
               6 => 'Bottom left',
               7 => 'Bottom center',
               8 => 'Bottom right' }
    # Initialize the cells in the UI
    update_cells
  end

  def not_over?
    @status == -1
  end

  # Core logic of tic-tac-toe
  def over?
    check_direction('diagonal')
    check_direction('column')
    check_direction('row')
    # Tie if all filled
    all_filled?
    @status
  end

  def check_direction(direction)
    if direction == 'row'
      rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
      direction(rows)
    elsif direction == 'column'
      columns = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
      direction(columns)
    else
      diagonals = [[0, 4, 8], [2, 4, 6]]
      direction(diagonals)
    end
  end

  def direction(indices_list)
    indices_list.each do |list|
      elements = @cells.select.with_index do |ele, index|
        ele if list.include?(index)
      end
      if elements.all?(1)
        @status = 1
      elsif elements.all?(2)
        @status = 2
      end
    end
  end

  def all_filled?
    filled = @cells.all? { |cell| cell != 0 }
    @status = 0 if filled
  end

  def update_cells
    @cells.each_with_index do |cell, index|
      case cell
      when 0
        @marks[index] = ' '
      when 1
        @marks[index] = @player1.symbol
      when 2
        @marks[index] = @player2.symbol
      end
    end
  end

  def display
    update_cells
    puts " #{@marks[0]} | #{@marks[1]} | #{@marks[2]} "
    puts '-----------'
    puts " #{@marks[3]} | #{@marks[4]} | #{@marks[5]} "
    puts '-----------'
    puts " #{@marks[6]} | #{@marks[7]} | #{@marks[8]} "
  end

  def list_available_moves
    puts 'Available moves: '
    @moves.each do |key, value|
      puts "#{key}. #{value}"
    end
  end

  def output_available_moves
    @moves.keys.map { |key| key }
  end

  def make_move(player, move)
    @cells[move] = if (player <=> @player1).nil?
                     1
                   else
                     2
                   end
    move = @moves.delete(move)
    puts "#{player.name} played #{move}."
    update_cells
  end
end
