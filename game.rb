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
      @black.move
    end
  end
end
