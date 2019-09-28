# frozen_string_literal: true

class Card
  include Symbolics
  attr_reader :suite, :rank
  def initialize(suite, rank)
    message_s = "#{suite} is not allowed"
    message_r = "#{rank} is not allowed"
    raise ArgumentError, message_s unless suites.include? suite
    raise ArgumentError, message_r unless ranks.include? rank

    @suite = suite
    @rank = rank
  end
end
