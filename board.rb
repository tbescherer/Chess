require 'byebug'

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

  def initialize(board=nil)
    @grid = Array.new(DIMENSIONS){ Array.new(DIMENSIONS) }
    board.nil? ? set_board : @grid = board
  end

  def [](row,col)
    @grid[row][col]
  end

  def []=(row,col,piece)
    @grid[row][col] = piece
  end

  def set_board
    set_row = Proc.new do |row, color, constant|
      constant.each_with_index do |piece, idx|
        self[row, idx] = piece.new(self, [row,idx], color)
      end
    end

    set_row.call(0,:black, BACK_ROW)
    set_row.call(7,:white, BACK_ROW)
    set_row.call(1,:black, FRONT_ROW)
    set_row.call(6,:white, FRONT_ROW)
  end

  def inspect
    nil
  end

  def display_board
    bg_color = :black
    @grid.each_with_index do |row, idx|
      row_str = "#{DIMENSIONS - idx} ".colorize(:color => :green)

      bg_color = bg_color == :white ? :black : :white
      row.each do |place|

        if place.nil?
          new_square = " ".colorize(:color => :white)
        elsif place.color == :black
          new_square = BLACK_PIECES[place.class].colorize(:color => :blue)
        else
          new_square = WHITE_PIECES[place.class].colorize(:color => :red)
        end

        row_str += "#{new_square} ".colorize(background: bg_color)
        bg_color = bg_color == :white ? :black : :white
      end

      puts row_str
    end
    print "  "
    "A".upto("H") { |col| print col.colorize(:color => :green) + " " }
    puts ""

    return nil
  end

  def self.coord(string)
    raise BadMoveError.new("Invalid. Try again.") unless string.length == 2
    col, row  = string.split("")
    [DIMENSIONS - row.to_i, col.upcase.ord % "A".ord]
  end

  def move(start_pos, end_pos, color)
    # Allows user to load/save
    if end_pos.nil?
      if start_pos == "save" || start_pos == "load"
        Game.save(self.grid) if start_pos == "save"
        Game.load if start_pos == "load"
        raise BadMoveError.new("Please enter a new move.")
      else
        raise BadMoveError.new("Can't read input as a move. Try again.")
      end
    end

    # Assigns var names to positions
    start_x, start_y = Board.coord(start_pos)
    end_x, end_y = Board.coord(end_pos)
    origin, move_to = self[start_x, start_y], [end_x, end_y]

    # Checks if move is valid
    if !origin.nil? && origin.color == color && origin.valid_for_piece?(move_to)

      # Move the pieces
      if !results_in_check?([start_x, start_y], move_to)

        # Particulr move condition for king
        if self[start_x, start_y].class == King
          if (end_y - start_y).abs == 2
            castle_rook((end_y - start_y), color)
            # assigns end_pos for ROOK
            # call move(rook.pos, end_pos, rook.color)
          end

          self[start_x, start_y].has_moved = true
        end

        self[end_x, end_y] = self[start_x, start_y]
        self[start_x, start_y] = nil
        self[end_x,end_y].pos = move_to
      else
        raise BadMoveError.new("Move puts you in check! Try again.")
      end
    else

      raise BadMoveError.new("Not a valid move! Try again.")
    end
  end

  def castle_rook(diff, color)
    x_coord = color == :white ? "1" : "8"

    if diff == -2
      y_coord = "a"
      new_y = "d"
    else
      y_coord = "h"
      new_y = "f"
    end

    origin_string = y_coord + x_coord
    terminus_string = new_y + x_coord

    if self[*Board.coord(origin_string)].class == Rook
      move(origin_string, terminus_string, color)
    else
      raise BadMoveError.new("Your valid move is not in this castle.")
    end
  end

  def check?(color)
    self.pieces(color).each do |piece|
      piece.moves.each do |move|
        return true if self[*move].class == King
      end
    end

    false
  end

  def pieces(color)
    @grid.flatten.compact.select do |piece|
      piece.color == color
    end
  end

  def dup_board
    future_board = Board.new
    @grid.each_with_index do |row, idx|
      row.each_with_index do |tile, jdx|
        if tile.nil?
          future_board[idx,jdx] = nil
        else
          future_board[idx, jdx] = tile.class.new(future_board, tile.pos, tile.color)
        end
      end
    end

    future_board
  end

  def results_in_check?(origin, move_to)
    future_board = dup_board

    future_board[*move_to] = future_board[*origin]
    future_board[*origin] = nil
    future_board[*move_to].pos = move_to

    opp_color = future_board[*move_to].color == :white ? :black : :white
    future_board.check?(opp_color)
  end

  def checkmate?

    if check?(:white)
      pieces(:black).each do |piece|
        piece.moves.each do |move|
          return false unless results_in_check?(piece.pos, move)
        end
      end
      return true
    end

    if check?(:black)
      pieces(:white).each do |piece|
        piece.moves.each do |move|
          return false unless results_in_check?(piece.pos, move)
        end
      end
      return true
    end

  end
end
