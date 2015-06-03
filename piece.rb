class Piece
  attr_accessor :board, :pos, :color

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def valid?(pos)
    x,y = pos

    return false unless pos.all?{|n| n.between?(0,Board::DIMENSIONS - 1)}
    if !board[x,y].nil?
      return false if board[x,y].color == color
    end

    true
  end

  def valid_for_piece?(pos)
    self.moves.include?(pos)
  end
end
