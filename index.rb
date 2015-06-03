require_relative './errors.rb'
require_relative './00_tree_node.rb'
require_relative './piece.rb'
require_relative './sliding_piece.rb'
require_relative './stepping_piece.rb'
require_relative './pawn.rb'
require_relative './knight.rb'
require_relative './king.rb'
require_relative './bishop.rb'
require_relative './queen.rb'
require_relative './rook.rb'
require_relative './board.rb'
require_relative './human_player.rb'
require_relative './game.rb'

if __FILE__ == $PROGRAM_NAME
  Game.new
end
