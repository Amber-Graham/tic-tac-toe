#brainstorming session...

#we need to initialize a board, so the board would be in a class.
#i would think we would start with class Players, then initialize player1 and player2?
#player1 and player2 would have choices that would also need to be stored
#the board will be created and will remember the player choices

#how do we initialize a board? i wonder if its a rows and column thing
  #we call on or if we actually layout a board with dashes.

#there are 3 outcomes: player1 wins, player2 wins, or a draw.

#i'd like to have a play again?[Y/N] feature as well. this will just loop back
  #to the beginning

#we're going to ask each player what their name is. then we will ask
  #each player where they want to play on the board. the choice will be permanent
  #and will stay that way until a new change happens (i wonder if this means that 
  #i will need to do attr_accessor on the choice?)

#the board will look something like this:
#  +---+---+---+
#  | 1 | 2 | 3 |
#  +---+---+---+
#  | 4 | 5 | 6 |
#  +---+---+---+
#  | 7 | 8 | 9 |
#  +---+---+---+

#but i'm not sure if there is a way to make this with code. that will be one of the
  #first things i check. I'm assuming there is a way to initialize this by passing
  #arguments to the board. Not sure yet. 

#i'm also not sure, but i'd like to make the board a fixed position in irb...
  #i don't know if that's possible. if not, a new line of code will show the board
  #with the reflected changes to it. I'd like it to auto-update if possible.

#the flow will be:
  #welcome to the game > player1 name > player2 name >
  #loop of player1 choice > player2 choice until the board is filled
  #the outcome of the game will display followed by a play again prompt

#my first attempt failed miserably. I'm going to foucs on using classes this
  #time. I will get it right.

class Game
  def initialize
    @turn = [false, false]
    create_board

    puts "Let's play a new tic-tac-toe game!"
    player1_name = get_name('1')
    player1_symbol = get_symbol(player1_name)
    @player1 = Player.new(player1_name, player1_symbol)
    player2_name = get_name('2')
    player2_symbol = get_symbol(player2_name)
    @player2 = Player.new(player2_name, player2_symbol)
    play
  end

  def play
    pick_first
    until game_end == true
      display_board

      player = @turn[0] ? @player1 : @player2
      play_move(player, get_move(player))
      @turn.reverse!
    end
    display_board
      winner = @turn[0] ? @player2 : @player1
      puts "#{winner} has won the game!"
  end

  private

  def pick_first
    @turn[rand(2)] = true
  end

  def get_move(player)
    puts "#{player}, make your move."
    gets.chomp.to_i
  end

  def create_board
    @board = {}
    1.upto(9) do |num|
      @board[num] = num.to_s
    end
  end

  def play_move(player,square)
    if square.between?(1, 9) && @board[square] == square.to_s
      @board[square] = player.symbol
    else
      puts "That square is taken! Please select a different square."
      play_move(player, get_move(player))
    end
  end

  def get_name(player_number)
    puts "Player ##{player_number}, enter your name:"
    player_name = gets.chomp
    until player_name.length.positive?
      puts 'You must enter some characters as a name.'
      player_name = gets.strip
    end
    player_name
  end

  def get_symbol(player_name)
    if @player1
      player_symbol = @player1.symbol == 'x' ? 'o' : 'x'
    else
      puts "#{player_name}, do you want to be 'x's or 'o's?"
      player_symbol = gets.chomp.downcase
      until %w[o x].include? player_symbol
        puts "You must enter either 'x' or 'o'"
        player_symbol = gets.chomp.downcase
      end
    end
    player_symbol
  end

  def display_board
    puts '+---+---+---+'
    @board.each do |key, value|
      if (key % 3).zero?
        puts "#{value} |"
        puts '+---+---+---+'
      elsif [1, 4, 7].include?(key)
        print "| #{value} | "
      else
        print "#{value} | "
      end
    end
  end

  def game_end
    unless @board.count { |_key, value| value == @player1.symbol } >= 3 ||
           @board.count { |_key, value| value == @player2.symbol } >= 3
      false
    end
    [1, 4, 7].each do |num|
      if @board[num] == @board[num + 1] && @board[num + 1] == @board[num + 2]
        return true
      end
    end
    [1, 2, 3].each do |num|
      if @board[num] == @board[num + 3] && @board[num + 3] == @board[num + 6]
        return true
      end
    end
    if @board[1] == @board[5] && @board[5] == @board[9]
      true
    elsif @board[3] == @board[5] && @board[5] == @board[7]
      true
    else
      false
    end
  end
end

  class Player
    attr_reader :symbol
    attr_accessor :moves

    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end

    def to_s
      @name.to_s
    end
  end

  Game.new


