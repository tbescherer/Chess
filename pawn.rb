class Pawn < SteppingPiece

  def valid?(pos) #class method for testing purposes
    x,y = pos
    return false unless pos.all?{|n| n.between?(0,Board::DIMENSIONS - 1)}
    if !board[x,y].nil?
      return false if board[x,y].color == color
    end
    #won't put in check
    true
  end

  # def moves
  #   deltas = self.class::DELTAS
  #   deltas.map do |x,y|
  #     [self.pos[0] + x, self.pos[1] + y]
  #   end.select { |pos| valid?(pos) }
  # end

  def valid_for_piece?(pos)
    self.moves.include?(pos)
  end

  def moves
    moves = []

    forward = Proc.new do |amount|
      move = [self.pos[0] + amount, self.pos[1]]
      moves << move if @board[*move].nil?
    end
    diagonal = Proc.new do |x, y|
      move = [self.pos[0] + x, self.pos[1] + y]
      moves << move if !@board[*move].nil? && @board[*move].color != self.color
    end

    if self.color == :white
      forward.call(-1)
      forward.call(-2) if self.pos[0] == 6
      diagonal.call(-1, 1)
      diagonal.call(-1, -1)
    else
      forward.call(1)
      forward.call(2) if self.pos[0] == 1
      diagonal.call(1, 1)
      diagonal.call(1, -1)
    end

    moves
  end
end
