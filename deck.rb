# frozen_string_literal: true

class Deck
  include Symbolics
  attr_reader :deck
  def initialize
    @deck = create_deck
  end

  def accept_cards(cards)
    cards.each { |card| raise ArgumentError, "#{card} is not a Card" unless card.is_a? Card }

    @deck.push(*cards)
  end

  def give_top_cards(amount)
    @deck.pop(amount)
  end

  def give_cards(indexes)
    cards = @deck.values_at(*indexes)
    @deck.delete_if {|card| cards.include? card}
    cards
  end

  def reset
    @deck = create_deck
  end

  private

  def create_deck
    self.class.suites.product(self.class.ranks).collect { |s, r| Card.new(s, r) }.shuffle
  end
end
