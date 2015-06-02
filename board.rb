class Board
  DIMENSIONS = 8
  attr_reader :board

  def initialize
    @grid = Array.new(DIMENSIONS){ Array.new(DIMENSIONS) }
  end

  def fill_board

  end

  def self.coord(string)
    row, col = string.split("")

    [row.upcase.ord % "A".ord,col.to_i - 1]
  end
end

# p Board.new.grid
