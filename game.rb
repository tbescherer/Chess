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
      puts "#{@black.name}, you're in Check!".colorize(:red) if @board.check?(:white)
      break if @board.checkmate?
      @black.move
      puts "#{@white.name}, you're in Check!".colorize(:red) if @board.check?(:black)
      break if @board.checkmate?
    end

    @board.display_board
    puts "Checkmate!".on_red
  end

  def self.save
    File.new("save.txt", "w+")
    File.open("save.txt", "w+") do |f|
      f.puts @board.to_yaml
    end
    puts "Game saved!"
  end

  def self.load(filename)
    file = File.read(filename)
    Game.new(YAML::load(file))
    puts "Game loaded!"
  end
end
