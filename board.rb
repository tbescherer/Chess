class Board
  DIMENSIONS = 8
  PIECES = {
    
  }
  BACK_ROW = [Rook,Knight,Bishop,Queen,King,Bishop,Knight,Rook]
  attr_accessor :grid

  def initialize
    @grid = Array.new(DIMENSIONS){ Array.new(DIMENSIONS) }
    set_board
  end

  def [](row,col)
    @grid[row][col]
  end

  def []=(row,col,piece)
    @grid[row][col] = piece
  end

  def set_board
    #set black PIECES
    set_row = Proc.new do |row, color|
      0.upto(DIMENSIONS - 1) do |idx|
        @grid[row][idx] = BACK_ROW[idx].new(self, [row,idx], color)
      end
    end

    set_row.call(0,:black)
    set_row.call(7,:white)


    # @grid[0].each_index do |idx|
    #   @grid[0][idx] = BACKROW[idx].new(self, [0,idx], :black)

    #set white pieces
    # @grid[0,0] =
  end

  def display_board
    @grid.each do |row|
      row

  end

  def self.coord(string)
    row, col = string.split("")

    [row.upcase.ord % "A".ord,col.to_i - 1]
  end
end

# p Board.new.grid
