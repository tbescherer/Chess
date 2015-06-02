class Piece
  attr_reader :board, :pos, :color

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def valid?(pos) #class method for testing purposes
    x,y = pos
    return false unless pos.all?{|n| n.between?(0,Board::DIMENSIONS - 1)}
    unless board[x,y].nil?
      return false if board[x,y].color == color
    end
    #won't put in check
    true
  end

  def moves
    deltas = self.class::DELTAS
    deltas.map do |x,y|
      [self.pos[0] + x, self.pos[1] + y]
    end.select { |pos| valid?(pos) }
  end

end
