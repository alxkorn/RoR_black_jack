# frozen_string_literal: true

class Deck
  include Symbolics
  def initialize
    @deck = create_deck
  end

  def accept_cards(cards)
    cards.each { |card| raise ArgumentError, "#{card} is not a Card" unless card.is_a? Card }

    @deck.push(*cards)
  end

  def give_cards(amount)
    @deck.pop(amount)
  end

  private

  def create_deck
    self.class.suites.product(self.class.ranks).collect { |s, r| Card.new(s, r) }.shuffle
  end
end
