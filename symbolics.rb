# frozen_string_literal: true

module Symbolics
  def self.suites
    ['♣', '♦', '♥', '♠']
  end

  def self.ranks
    numeric_ranks + [jack, queen, king, ace]
  end

  def self.numeric_ranks
    [*'2'..'10']
  end

  def self.jack
    'J'
  end

  def self.queen
    'Q'
  end

  def self.king
    'Q'
  end

  def self.ace
    'A'
  end
end
