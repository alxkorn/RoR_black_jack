# frozen_string_literal: true

class Player
  attr_reader :name, :balance
  def initialize(name, balance, bank, deck)
    @name = name
    @hand = Hand.new
    @bank = bank
    @deck = deck
    @balance = balance
  end

  def bet(amount)
    remaining = @balance - amount
    raise NoFundsError, 'Insufficient funds' unless remaining.positive?

    @balance = remaining
    @bank.receive_bet(self, amount)
  end

  def receive_money(amount)
    @balance += amount
  end

  def deal(amount)
    @hand.accept_cards(@deck.deal_top_cards(amount))
  end

  def cards
    @hand.cards
  end

  # def release_hand
  #   cards = @hand.cards
  #   reset_hand
  #   cards
  # end

  def reset_hand
    @hand.reset
  end
end
