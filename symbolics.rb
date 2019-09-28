# frozen_string_literal: true

module Symbolics
  def suites
    ['♣', '♦', '♥', '♠']
  end

  def ranks
    numeric_ranks + [jack, queen, king, ace]
  end

  def numeric_ranks
    [*'2'..'10']
  end

  def jack
    'J'
  end

  def queen
    'Q'
  end

  def king
    'Q'
  end

  def ace
    'A'
  end
end
