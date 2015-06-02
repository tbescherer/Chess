class Piece
  def initialize(board, pos)
    @board = board
    @pos = pos
  end



  def valid_moves #for all pieces

    #is on board
    #doesn't contain ally
    #won't put in check
  end

  def moves
    deltas = self.class::DELTAS
  end

end
