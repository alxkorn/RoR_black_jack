# frozen_string_literal: true

class BJCalculator
  HIGH_RANK_VALUE = 10
  ACE_VALUE_HIGH = 11
  ACE_VALUE_LOW = 1
  BLACKJACK = 21

  def self.blackjack
    BLACKJACK
  end

  def initialize
    values = Card.numeric_ranks.map(&:to_i) + [HIGH_RANK_VALUE] * Card.high_ranks.size
    @value_chart = Hash[(Card.numeric_ranks+Card.high_ranks).zip(values)]
  end

  def calculate_value(cards)
    value = 0
    ace_cards, other_cards = cards.partition { |card| card.rank == Card.ace }
    other_cards.each { |card| value += @value_chart[card.rank] }
    unless ace_cards.empty?
      aces_value_high = ACE_VALUE_HIGH + (ace_cards.size - 1) * ACE_VALUE_LOW
      aces_value_low = ace_cards.size * ACE_VALUE_LOW
      value += if value + aces_value_high <= BLACKJACK
                aces_value_high
               else
                aces_value_low
               end
    end
    value
  end
end
