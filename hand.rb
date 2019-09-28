class Hand < Deck
  attr_reader :cards
  def initialize
    @cards = []
  end

  def reset
    @cards = []
  end
end