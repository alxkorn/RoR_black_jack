# frozen_string_literal: true

class Card
  attr_reader :suite, :rank
  def initialize(suite, rank)
    message_s = "#{suite} is not allowed"
    message_r = "#{rank} is not allowed"
    raise ArgumentError, message_s unless Symbolics.suites.include? suite
    raise ArgumentError, message_r unless Symbolics.ranks.include? rank

    @suite = suite
    @rank = rank
  end
end
