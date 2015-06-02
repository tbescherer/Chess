class HumanPlayer
  attr_reader :name
  def initialize(color, board)
    @name = name
    @color = color
    @board = board
  end

  def name
    puts "What is your name, #{@color}?"
    gets.chomp
  end

  def move
    @board.display_board
    print "#{@color.to_s}: Enter start and end position, divided by a dash: "
    start_pos, end_pos = gets.chomp.split('-')

    start_x, start_y = Board.coord(start_pos)
    end_x, end_y = Board.coord(end_pos)
    origin, destination = @board[start_x, start_y], @board[end_x, end_y]

    p origin
    p destination

    if !origin.nil? && origin.valid?([end_x, end_y])
        destination, origin = origin, nil
    end

    puts "You made it!"
  end
end
