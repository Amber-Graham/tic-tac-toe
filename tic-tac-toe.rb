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