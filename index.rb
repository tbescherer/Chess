require 'colorize'
require_relative './lib/errors.rb'
require_relative './lib/pieces/piece.rb'
require_relative './lib/pieces/sliding_piece.rb'
require_relative './lib/pieces/stepping_piece.rb'
require_relative './lib/pieces/pawn.rb'
require_relative './lib/pieces/knight.rb'
require_relative './lib/pieces/king.rb'
require_relative './lib/pieces/bishop.rb'
require_relative './lib/pieces/queen.rb'
require_relative './lib/pieces/rook.rb'
require_relative './lib/board.rb'
require_relative './lib/human_player.rb'
require_relative './lib/game.rb'

if __FILE__ == $PROGRAM_NAME
  Game.new
end
