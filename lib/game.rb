require 'yaml'

class Game
  def initialize(board = nil, color = :white)
    other_color = color == :white ? :black : :white
    @board = board.nil? ? Board.new : Board.new(board)
    @player1 = HumanPlayer.new(color, @board)
    @player2 = HumanPlayer.new(other_color, @board)
    play
  end

  def play
    loop do
      @player1.move
      puts "#{@player2.name}, you're in Check!".colorize(:red) if @board.check?(@player1.color)
      break if @board.checkmate?
      @player2.move
      puts "#{@player1.name}, you're in Check!".colorize(:red) if @board.check?(@player2.color)
      break if @board.checkmate?
    end

    @board.display_board
    puts "Checkmate!".on_red
  end

  def self.save(grid, color)
    File.new("save.txt", "w+")
    save_data = {
      grid: grid,
      color: color
    }
    File.open("save.txt", "w+") do |f|
      f.puts save_data.to_yaml
    end
    puts "Board saved!!"
  end

  def self.load
    file = File.read("save.txt")
    loaded_data = YAML.load(file)
    Game.new(loaded_data[:grid], loaded_data[:color])
    puts "Board loaded!!"
  end
end
