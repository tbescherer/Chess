require 'yaml'
class Game

  def initialize(board = nil)
    @board = board.nil? ? Board.new : Board.new(board)
    @white = HumanPlayer.new(:white, @board)
    @black = HumanPlayer.new(:black, @board)
    play
  end

  def play
    loop do
      @white.move
      puts "#{@black.name}, you're in Check!" if @board.check?(:white)
      break if @board.checkmate?
      @black.move
      puts "#{@white.name}, you're in Check!" if @board.check?(:black)
      break if @board.checkmate?
    end
    @board.display
    puts "Checkmate #{@board.checkmate?.to_s}!"
  end

  def save
    File.new("save.txt", "w+")
    File.open("save.txt", "w+") do |f|
      f.puts @board.to_yaml
    end
  end

  def self.load(filename)
    file = File.read(filename)
    Game.new(YAML::load(file))
  end
end
