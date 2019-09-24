# frozen_string_literal: true

class Deck
  attr_reader :deck
  def initialize
    @suites = ['♣', '♦', '♥', '♠']
    @ranks = [*'2'..'10'] + %w[J Q K A]
    @deck = @suites.product(@ranks).collect { |s, r| { 'suite' => s, 'rank' => r } }
  end
end
