class Game
  def initialize
    puts 'Please insert first player\'s name:'
    name = gets.chomp
    @player1 = Player.new(name)
    puts 'Please insert second player\'s name:'
    name = gets.chomp
    @player2 = Player.new(name)
    create_board
    @symbol1 = 'x'
    @symbol2 = 'o'
    play
  end

  def play
    @won = false
    order = 1
    until @won == true
      column_choice = ask_for_column(order)
      check_who_won(order, column_choice - 1)
      order == 1 ? order += 1 : order -= 1
    end
    ask_to_play_again
  end

  def create_board
    @header = []
    7.times { |i| @header[i] = i + 1 }
    @board = []
    6.times do |i|
      @board[i] = Array.new(7, '_')
    end
  end

  def display_board
    print "#{@header.join(' | ')} \n"
    @board.each { |array| print "#{array.join(' | ')} \n" }
  end

  def update_board(column, order)
    symbol = order == 1 ? @symbol1 : @symbol2
    i = @board.length - 1
    while i >= 0
      if @board[i][column] == '_'
        @board[i][column] = symbol
        return true
      end
      i -= 1
    end
    puts 'That column is full'
    false
  end

  def ask_for_column(order)
    puts order == 1 ? "#{@player1.name}, please choose the column where you want to put your symbol" : "#{@player2.name}, please choose the column where you want to put your symbol"
    display_board
    column_choice = gets.chomp
    until column_choice.match(/[1-7]/) && update_board(column_choice.to_i - 1, order)
      puts 'Please insert a valid column number'
      column_choice = gets.chomp
    end
    column_choice.to_i
  end

  def check_who_won(order, column)
    symbol = order == 1 ? @symbol1 : @symbol2
    player = order == 1 ? @player1 : @player2
    @board.each do |row|
      (0..3).each do |i|
        next unless row[i] == symbol && row[i] == row[i + 1] && row[i] == row[i + 2] && row[i] == row[i + 3]
				display_board
        player.score += 1
        puts "Yay! Player #{player.name} won! Score is #{@player1.name}:#{@player1.score}, #{@player2.name}:#{@player2.score}"
        @won = true
        return
      end
    end
    i = 5
    while i >= 3
      if @board[i][column] == symbol && @board[i - 1][column] == symbol && @board[i - 2][column] == symbol && @board[i - 3][column] == symbol
				display_board
        player.score += 1
        puts "Yay! Player #{player.name} won! Score is #{@player1.name}:#{@player1.score}, #{@player2.name}:#{@player2.score}"
        @won = true
        return
      end
      i -= 1
    end
    i = 5
    while i >= 3
      j = 0
      while j <= 3
        if @board[i][j] == symbol && @board[i - 1][j + 1] == symbol && @board[i - 2][j + 2] == symbol && @board[i - 3][j + 3] == symbol
					display_board
          player.score += 1
          puts "Yay! Player #{player.name} won! Score is #{@player1.name}:#{@player1.score}, #{@player2.name}:#{@player2.score}"
          @won = true
          return
        end
        j += 1
      end
      i -= 1
    end
    i = 5
    while i >= 3
      j = 6
      while j >= 3
        if @board[i][j] == symbol && @board[i - 1][j - 1] == symbol && @board[i - 2][j - 2] == symbol && @board[i - 3][j - 3] == symbol
					display_board
          player.score += 1
          puts "Yay! Player #{player.name} won! Score is #{@player1.name}:#{@player1.score}, #{@player2.name}:#{@player2.score}"
          @won = true
          return
        end
        j -= 1
      end
      i -= 1
    end
  end

  def ask_to_play_again
    puts 'Do you want to play again? Y/N'
    answer = gets.chomp.downcase
    until %w[y n].include?(answer)
      puts 'You must answer with y or n'
      answer = gets.chomp.downcase
    end
    if answer == 'n'
      puts 'Okay :( Maybe next time!'
    else
      reset_game
    end
  end

  def reset_game
    create_board
    play
  end
end

class Player
  attr_accessor :name, :score

  def initialize(name)
    @name = name
    @score = 0
  end
end

puts 'Hello! Do you wanna play a game of Connect-Four? Y/N'
answer = gets.chomp.downcase
until %w[y n].include?(answer)
  puts 'You must answer with y or n'
  answer = gets.chomp.downcase
end
if answer == 'n'
  puts 'Okay :( Maybe next time!'
else
  game = Game.new
end
