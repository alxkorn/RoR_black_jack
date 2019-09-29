# frozen_string_literal: true

class Card
  SUITES = ['♣', '♦', '♥', '♠'].freeze
  NUMERIC_RANKS = ('2'..'10').to_a.freeze
  HIGH_RANKS = %w[J Q K].freeze
  ACE = 'A'
  RANKS = NUMERIC_RANKS + HIGH_RANKS + [ACE]
  def self.suites
    SUITES
  end

  def self.high_ranks
    HIGH_RANKS
  end

  def self.numeric_ranks
    NUMERIC_RANKS
  end

  def self.ranks
    RANKS
  end

  def self.ace
    ACE
  end

  attr_reader :suite, :rank
  def initialize(suite, rank)
    @suite = suite
    @rank = rank
    validate!
  end

  private

  def validate!
    message_s = "#{@suite} is not allowed"
    message_r = "#{@rank} is not allowed"
    raise ArgumentError, message_s unless SUITES.include? @suite
    raise ArgumentError, message_r unless RANKS.include? @rank
  end

  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end
end
