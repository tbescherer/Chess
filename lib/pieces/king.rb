class King < SteppingPiece
  DELTAS = [
    [0,1],
    [0,-1],
    [1, -1],
    [1, 0],
    [1, 1],
    [-1, -1],
    [-1, 0],
    [-1, 1]
  ]

  CASTLING_DELTAS = [
    [0, 2],
    [0, -2]
  ]

  attr_accessor :has_moved

  def initialize (board, pos, color)
    super(board, pos, color)
    @has_moved = false
  end

  def moves
    deltas = self.class::DELTAS
    deltas += self.class::CASTLING_DELTAS unless has_moved
    deltas.map do |x,y|
      [self.pos[0] + x, self.pos[1] + y]
    end.select { |pos| valid?(pos) }
  end

end
