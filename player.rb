# frozen_string_literal: true

class Player
  DEFAULT_BET = 10
  attr_reader :name, :hand
  def initialize(name)
    @name = name
    @hand = Hand.new
    @calculator = BJCalculator.new
  end

  def bet(bank, amount = DEFAULT_BET)
    bank.receive_bet(self, amount)
  end

  def deal(deck, amount)
    @hand.accept_cards(deck.deal_top_cards(amount))
  end

  def cards
    @hand.cards
  end

  def cards_string
    cards_str = ''
    @hand.cards.each do |card|
      cards_str = [cards_str, card.suite + card.rank].join(' ')
    end
    cards_str
  end

  def hand_value
    return 0 if cards.empty?

    @calculator.calculate_value(cards)
  end

  def reset_hand
    @hand.reset
  end
end
