class Board
  DIMENSIONS = 8
  WHITE_PIECES = {
    Pawn => "\u2659",
    Knight => "\u2658",
    Bishop => "\u2657",
    Rook => "\u2656",
    Queen => "\u2655",
    King => "\u2654"
  }

  BLACK_PIECES = {
    Pawn => "\u265F",
    Knight => "\u265E",
    Bishop => "\u265D",
    Rook => "\u265C",
    Queen => "\u265B",
    King => "\u265A"
  }
  BACK_ROW = [Rook,Knight,Bishop,Queen,King,Bishop,Knight,Rook]
  FRONT_ROW =  [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]
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
    set_row = Proc.new do |row, color, constant|
      0.upto(DIMENSIONS - 1) do |idx|
        @grid[row][idx] = constant[idx].new(self, [row,idx], color)
      end
    end

    set_row.call(0,:black, BACK_ROW)
    set_row.call(7,:white, BACK_ROW)
    set_row.call(1,:black, FRONT_ROW)
    set_row.call(6,:white, FRONT_ROW)


    # @grid[0].each_index do |idx|
    #   @grid[0][idx] = BACKROW[idx].new(self, [0,idx], :black)

    #set white pieces
    # @grid[0,0] =
  end

  def inspect
    nil
  end

  def display_board
    @grid.each do |row|
      row_str = ""
      row.each do |place|
        if place.nil?
          row_str += "\u25A1"
        elsif place.color == :black
          row_str += BLACK_PIECES[place.class]
        else
          row_str += WHITE_PIECES[place.class]
        end
      end
      puts row_str
    end

    return nil
  end

  def self.coord(string)
    row, col = string.split("")

    [row.upcase.ord % "A".ord,col.to_i - 1]
  end
end

# p Board.new.grid
