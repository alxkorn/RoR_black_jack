# frozen_string_literal: true

class BJGame
  include BJConstants
  def initialize
    @interface = BJInterface.new
    name = @interface.request_name
    @player = Player.new(name)
    @dealer = Dealer.new
    @deck = Deck.new
    @bank = Bank.new
    @bank.register_player(@player, const_default_balance)
    @bank.register_player(@dealer, const_default_balance)
    @round_playing = true
    @end_game = false
  end

  def start
    until @end_game
      play_round
      @end_game = @interface.play_again?
    end
  end

  private

  def play_round
    reset_round
    while playing?
      @interface.show_info(info)
      action = @interface.request_action(actions)
      send action
      break unless playing?

      @dealer.play_round(@deck)
      detect_end
    end
  end

  def actions
    action_list = []
    condition = @player.cards.size < const_max_cards
    action_list << { 'message' => 'Взять карту', 'action' => :player_hit } if condition
    action_list << { 'message' => 'Пропустить ход', 'action' => :player_pass }
    action_list << { 'message' => 'Открыть карты', 'action' => :player_open }
    action_list
  end

  def reset_round
    @round_playing = true
    @player.reset_hand
    @dealer.reset_hand
    @deck.reset
    @player.deal(@deck, const_new_round_cards_num)
    @dealer.deal(@deck, const_new_round_cards_num)
    @player.bet(@bank, const_default_bet)
    @dealer.bet(@bank, const_default_bet)
  end

  def playing?
    @round_playing
  end

  def detect_end
    if @player.cards.size == const_max_cards && @player.cards.size == const_max_cards
      @interface.show_info(info)
      player_open
    end
  end

  def player_hit
    @player.deal(@deck, const_take_cards_num)
    @interface.show_info(info)
  end

  def player_pass; end

  def player_open
    @round_playing = false
    @interface.show_info(info)
    @bank.release_win(winner)
    @interface.inform_winner(winner)
  end

  def winner
    return nil if @player.hand_value > const_black_jack && @dealer.hand_value > const_black_jack
    return nil if @player.hand_value == @dealer.hand_value
    return @dealer if @player.hand_value > const_black_jack
    return @player if @dealer.hand_value > const_black_jack

    scores = [[@player, const_black_jack - @player.hand_value], [@dealer, const_black_jack - @dealer.hand_value]]
    winner = scores.min_by { |elem| elem[1] }[0]
    winner
  end

  def info
    { 'player' => @player, 'dealer' => @dealer, 'bank' => @bank, 'round_playing' => playing? }
  end
end
