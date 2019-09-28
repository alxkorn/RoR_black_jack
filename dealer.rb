class Dealer < Player
  include BJConstants
  def initialize
    name = 'Dealer'
    super(name)
  end

  def play_round(deck)
    if cards.size < const_max_cards && hand_value < const_optimal_value
      deal(deck, const_take_cards_num)
    end
  end
end