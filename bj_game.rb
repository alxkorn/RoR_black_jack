# frozen_string_literal: true

class BJGame
  OPTIMAL_VALUE = 17
  NEW_ROUND_CARDS_NUM = 2
  TAKE_CARDS_NUM = 1
  DEALER_NAME = 'Dealer'
  def initialize
    @interface = BJInterface.new
    name = @interface.request_name
    @player = Player.new(name)
    @dealer = Player.new(DEALER_NAME)
    @deck = Deck.new
    @bank = Bank.new
    @bank.register_player(@player)
    @bank.register_player(@dealer)
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

      dealer_turn
      detect_end
    end
  end

  def dealer_turn
    if @dealer.cards.size < Hand.max_cards && @dealer.hand_value < OPTIMAL_VALUE
      @dealer.deal(@deck, TAKE_CARDS_NUM)
    end
  end

  def actions
    action_list = []
    condition = @player.cards.size < Hand.max_cards
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
    @player.deal(@deck, NEW_ROUND_CARDS_NUM)
    @dealer.deal(@deck, NEW_ROUND_CARDS_NUM)
    begin
      @player.bet(@bank)
    rescue NoFundsError
      @interface.funds_warning(@player)
      exit(0)
    end
    begin
      @dealer.bet(@bank)
    rescue NoFundsError
      @interface.funds_warning(@dealer)
      exit(0)
    end
  end

  def playing?
    @round_playing
  end

  def detect_end
    if @player.cards.size == Hand.max_cards && @player.cards.size == Hand.max_cards
      @interface.show_info(info)
      player_open
    end
  end

  def player_hit
    @player.deal(@deck, TAKE_CARDS_NUM)
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
    const_black_jack = BJCalculator.blackjack
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
