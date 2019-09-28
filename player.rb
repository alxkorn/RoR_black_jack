# frozen_string_literal: true

class Player
  attr_reader :name, :hand
  def initialize(name)
    @name = name
    @hand = Hand.new
    # @bank = bank
    # @deck = deck
    # @balance = PlayerBalance.new(balance)
  end

  def bet(amount, bank)
    bank.receive_bet(self, amount)
  end

  def deal(deck, amount)
    @hand.accept_cards(deck.deal_top_cards(amount))
  end

  def cards
    @hand.cards
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
