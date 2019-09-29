# frozen_string_literal: true

require_relative('no_funds_error')
require_relative('player_not_found_error')
require_relative('invalid_action_error')
require_relative('cards_limit_error')
require_relative('card')
require_relative('deck')
require_relative('hand')
require_relative('bank')
require_relative('player_balance.rb')
require_relative('player')
require_relative('bj_calculator')
require_relative('bj_interface')
require_relative('bj_game')

game = BJGame.new
game.start
