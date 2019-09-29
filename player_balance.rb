class PlayerBalance
  attr_reader :balance, :player
  def initialize(player, balance)
    @player = player
    @balance = balance
  end

  def receive_money(amount)
    @balance += amount
  end

  def give_money(amount)
    remaining = @balance - amount
    raise NoFundsError, 'Insufficient funds' unless remaining.positive?

    @balance = remaining
    amount
  end
end