class Player
  attr_reader :name
  def initialize(name, default_balance)
    @name = name
    @hand = Hand.new
    @bank = Bank.new(default_balance)
  end

  def give_money(amount)
    @bank.withdraw(amount)
  end

  def balance
    @bank.balance
  end

  def cards
    @hand.deck
  end

  def take_money(amount)
    @bank.add(amount)
  end

  def take_cards(cards)
    @hand.accept_cards(cards)
  end

  def give_top_cards(amount)
    @hand.give_top_cards(amount)
  end

  def give_cards(indexes)
    @hand.give_cards(indexes)
  end

  def reset_hand
    @hand.reset
  end
end