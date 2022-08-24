class TicTacToe
  attr_accessor :name1, :name2, :game_data
  
  def initialize
    game_welcome
    game_loop 
  end

  def game_welcome
    puts "LET'S GET READY TO TIC-TAC-TOEEEE!!!!"
    puts "+---+---+---+---+---+---+---+---+---+"
    print "Player 1, what would you like to be called?\n"
    @name1 = gets.strip
    puts " "
    print "Player 2 what would you like to be called?\n"
    @name2 = gets.strip
    puts " "
  end

  def game_loop
    game_start
    play_again
  end

  def game_start
    board = Board.new
    player1, player2 = Player.new(@name1), Player.new(@name2)
    game = Game.new(player1, player2, board)
  end

  def play_again
    input = nil
    until input == "Y" or input == "N"
      puts "Would you like to play again? (Y/N):\n"
      input = gets.chomp.upcase
    end
    case input
    when "Y"
      game_start
    when "N"
      puts "See you soon!"
    end
  end
end


class Player
  attr_accessor :name, :symbol
  def initialize(name)
    @name = name
  end
end


class Board
  attr_accessor :spaces
  def initialize
    @spaces = Array.new(9) {|n| n + 1}
  end

  def create_board
    board = ""
    puts "+---+---+---+"
      (0..8).step(3) do |i|
        board += "| #{@spaces[i]} | #{@spaces[i + 1]} | #{@spaces[i + 2]} |\n+---+---+---+\n"
      end
      puts board + "\n"
  end
  
  def add_symbol(position, symbol)
    @spaces[position] = symbol
  end

  def valid_move?(position)
    return @spaces[position] == "X" || @spaces[position] == "O"
  end
end


class Game
  attr_accessor :player1, :player2, :turn, :board

  WINNING_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
    
    @current_turn = 1
    @first_turn = ""
    @winner = ""

    play 
  end

  def play
    pick_first_turn
    assign_symbols
    take_turns
  end

  private

  def pick_first_turn
    @first_turn = [@player1.name, @player2.name].sample
    puts "#{@first_turn} will go first!"
  end

  def assign_symbols
    @player1.symbol = "X"
    @player2.symbol = "O"
  end

  def take_turns
    until draw? || @winner != ""
      if @first_turn == @player1.name
        (@current_turn.even?) ? turn(@player2) : turn(@player1)
      elsif @first_turn == @player2.name
        (@current_turn.even?) ? turn(@player1) : turn(@player2)
      end
    end
    puts "The game was a draw!" if draw?
  end

  def turn(player)
    @board.create_board
    @board.add_symbol(get_valid_position(player), player.symbol)
    announce_win(player)
    @current_turn += 1
  end

  def get_valid_position(player)
    input = 0
    until valid_input?(input)
      print "#{player.name}, make your move!\n"
      input = gets.strip.to_i
      print "Invalid input!" unless valid_input?(input)
      puts "Please select a valid space in the range of 1-9." unless (input > 0 && input < 10)
      puts "The space is taken! Please select another space." if @board.valid_move?(input - 1)
    end
    input - 1
  end

  def announce_win(player)
    check_winner(player)
    if @winner == player.name
      puts "Congratulations #{player.name}! You win!"
    end
  end

  def draw?
    (@current_turn == @board.spaces.length) && (@winner == "")
  end

  def check_winner(player)
    WINNING_COMBINATIONS.each do |sequence|
      @winner = player.name if sequence.all? {|a| @board.spaces[a] == player.symbol}
    end
  end

  def valid_input?(input)
    return input > 0 && input < 10 && !@board.valid_move?(input - 1)
  end
end

TicTacToe.new