class HumanPlayer
  attr_reader :name, :color

  def initialize(color, board)
    @color = color
    @name = name
    @board = board
  end

  def name
    puts "What is your name, #{@color.to_s}?"
    gets.chomp
  end

  def move
    @board.display_board
    print "#{@color.to_s}: Enter start and end position, divided by a dash: "
    start_pos, end_pos = gets.chomp.split('-')
    raise BadMoveError.new("Not a valid command.") if start_pos.nil? || end_pos.nil?

    start_x, start_y = Board.coord(start_pos)
    end_x, end_y = Board.coord(end_pos)
    origin, destination = @board[start_x, start_y], @board[end_x, end_y]

    p origin
    p destination

    if !origin.nil? && origin.color == @color && origin.valid?([end_x, end_y])
      @board[end_x, end_y] = @board[start_x, start_y]
      @board[start_x, start_y] = nil
    else
      raise BadMoveError.new("Not a valid move.")
    end

    rescue BadMoveError => e
    puts e.message
    retry
  end
end
