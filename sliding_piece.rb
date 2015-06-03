class SlidingPiece < Piece

  def moves
    deltas = self.class::DELTAS
    # directions = Array.new(DELTAS.count){ Array.new }

    # deltas.each_with_index do |x, y, idx|
    #   directions[idx] << [self.pos[0] + x, self.pos[1] + y]
    # end
    directions = []
    deltas.each do |x,y|
      x_count = x
      y_count = y
      until !valid?([self.pos[0] + x_count, self.pos[1] + y_count])
        square = [self.pos[0] + x_count, self.pos[1] + y_count]
        directions << square
        x_count += x
        y_count += y
        break unless board[*square].nil?
      end
    end

    directions
  end
end
