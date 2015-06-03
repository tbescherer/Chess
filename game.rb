class Game

  def initialize
    @board = Board.new
    @white = HumanPlayer.new(:white, @board)
    @black = HumanPlayer.new(:black, @board)
    play
  end

  def play
    loop do
      @white.move
      puts "#{@black.name}, you're in Check!" if @board.check?(:white)
      @black.move
      puts "#{@white.name}, you're in Check!" if @board.check?(:black)
    end
  end


end
