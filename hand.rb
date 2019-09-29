# frozen_string_literal: true

class Hand < Deck
  MAX_CARDS = 3
  attr_reader :cards
  def self.max_cards
    MAX_CARDS
  end

  def accept_cards(cards)
    message = "Hand should have no more than #{MAX_CARDS} cards"
    raise CardLimitError, message if cards.size >= MAX_CARDS

    super(cards)
  end

  def initialize
    @cards = []
  end

  def reset
    @cards = []
  end
end
