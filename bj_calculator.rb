# frozen_string_literal: true

class BJCalculator
  HIGH_RANK_VALUE = 10
  ACE_VALUE_HIGH = 11
  ACE_VALUE_LOW = 1
  BLACK_JACK = 21
  num_ranks = Symbolics.numeric_ranks
  high_ranks = [Symbolics.jack, Symbolics.queen, Symbolics.king]
  ranks = num_ranks + high_ranks
  values = num_ranks.map(&:to_i) + [HIGH_RANK_VALUE] * high_ranks.size
  @value_chart = Hash[ranks.zip(values)]

  def self.calculate_value(cards)
    value = 0
    ace_cards, other_cards = cards.partition { |card| card.rank == Symbolics.ace }
    other_cards.each { |card| value += @value_chart[card.rank] }
    ace_cards.each do |_card|
      value += if value + ACE_VALUE_HIGH <= BLACK_JACK
                 ACE_VALUE_HIGH
               else
                 ACE_VALUE_LOW
               end
    end
    value
  end
end
