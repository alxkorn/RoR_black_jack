# frozen_string_literal: true

class Player
  include BJConstants
  attr_reader :name, :hand
  def initialize(name)
    @name = name
    @hand = Hand.new
    @calculator = BJCalculator.new
    # @bank = bank
    # @deck = deck
    # @balance = PlayerBalance.new(balance)
  end

  def bet(bank, amount)
    bank.receive_bet(self, amount)
  end

  def deal(deck, amount)
    message = "Hand should have no more than #{const_max_cards} cards"
    raise CardLimitError, message if cards.size >= const_max_cards

    @hand.accept_cards(deck.deal_top_cards(amount))
  end

  def cards
    @hand.cards
  end

  def cards_string
    cards_str = ''
    @hand.cards.each do |card|
      [cards_str, card.suite + card.rank].join(' ')
    end
    cards_str
  end

  def hand_value
    return 0 if cards.empty?

    @calculator.calculate_value(cards)
  end

  # def release_hand
  #   cards = @hand.cards
  #   reset_hand
  #   cards
  # end

  def reset_hand
    @hand.reset
  end
end
