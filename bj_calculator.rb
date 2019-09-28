# frozen_string_literal: true

class BJCalculator
  include Symbolics
  include BJConstants
  def initialize
    high_ranks = [jack, queen, king]
    ranks = numeric_ranks + high_ranks
    values = numeric_ranks.map(&:to_i) + [const_high_rank_value] * high_ranks.size
    @value_chart = Hash[ranks.zip(values)]
  end

  def calculate_value(cards)
    value = 0
    ace_cards, other_cards = cards.partition { |card| card.rank == Symbolics.ace }
    other_cards.each { |card| value += @value_chart[card.rank] }
    ace_cards.each do |_card|
      value += if value + const_ace_value_high <= const_black_jack
                 const_ace_value_high
               else
                 const_ace_value_low
               end
    end
    value
  end
end
