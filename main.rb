# frozen_string_literal: true

# A game of Tic-Tac-Toe.
#
# This class is responsible for managing the game state and determining the winner.
class Game
  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @current_player = @player1
  end

  def play
    puts 'Welcome to Tic-Tac-Toe!'
    @board.display

    loop do
      @current_player.move(@board)
      @board.display

      if winner?(@current_player.token)
        puts "Congratulations, #{@current_player_name}! You won!"
        break
      elsif draw?
        puts "It's a draw!"
        break
      end

      switch_player
    end

    puts 'Thanks for playing!'
  end

  def winner?(token)
    winning_combinations = [
      [[0, 0], [0, 1], [0, 2]],
      [[1, 0], [1, 1], [1, 2]],
      [[2, 0], [2, 1], [2, 2]],
      [[0, 0], [1, 0], [2, 0]],
      [[0, 1], [1, 1], [2, 1]],
      [[0, 2], [1, 2], [2, 2]],
      [[0, 0], [1, 1], [2, 2]],
      [[0, 2], [1, 1], [2, 0]]
    ]

    winning_combinations.any? do |combination|
      combination.all? { |row, column| @board.grid[row][column] == token }
    end
  end

  def draw?
    @board.grid.flatten.none? { |cell| cell == '_' }
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end

# The game board for a game of Tic-Tac-Toe.
#
# This class represents the game board and updates the state of the board after each move.
class Board
  attr_accessor :grid

  def initialize
    @grid = [%w[_ _ _], %w[_ _ _], %w[_ _ _]]
  end

  def display
    @grid.each do |row|
      row.each do |cell|
        print "#{cell} "
      end
      puts
    end
  end
end

# A player in a game of Tic-Tac-Toe.
#
# This class represents the players in the game.
class Player
  attr_accessor :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end

  def move(board)
    puts "#{@name}, please indicate your next move with two numbers separated by a comma."
    puts 'The first number represents the row (0-2), and the second number represents the column (0-2).'
    input = gets.chomp
    row, column = input.split(',')

    if valid_move?(row, column, board)
      board.grid[row.to_i][column.to_i] = @token
    else
      puts 'Invalid move! Please try again.'
      move(board)
    end
  end

  def valid_move?(row, column, board)
    row.to_i.between?(0, 2) && column.to_i.between?(0, 2) && board.grid[row.to_i][column.to_i] == '_'
  end
end

Game.new.play
