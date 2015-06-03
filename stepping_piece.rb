class SteppingPiece < Piece

  def moves
    deltas = self.class::DELTAS
    deltas.map do |x,y|
      [self.pos[0] + x, self.pos[1] + y]
    end.select { |pos| valid?(pos) }
  end

end
