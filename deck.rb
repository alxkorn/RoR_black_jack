# frozen_string_literal: true

class Deck
  attr_reader :deck
  def initialize
    @cards = create_deck
  end

  def accept_cards(cards)
    cards.each { |card| raise ArgumentError, "#{card} is not a Card" unless card.is_a? Card }

    @cards.push(*cards)
  end

  def deal_top_cards(amount)
    @cards.pop(amount)
  end

  # def deal_top_cards_to(amount, player)
  #   raise ArgumentError, 'player should be of type Player' unless player.is_a? Player

  #   player.hand.accept_cards(@cards.pop(amount))
  # end

  def deal_cards(indexes)
    cards = @cards.values_at(*indexes)
    @cards.delete_if { |card| cards.include? card }
    cards
  end

  def reset
    @cards = create_deck
  end

  private

  def create_deck
    Symbolics.suites.product(Symbolics.ranks).collect { |s, r| Card.new(s, r) }.shuffle
  end
end
