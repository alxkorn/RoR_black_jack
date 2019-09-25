class Bank
  attr_reader :balance
  def initialize(value)
    @balance = value
  end

  def withdraw(amount)
    raise ArgumentError, "Amount should be numeric" unless amount.is_a? Numeric
    remaining = balance - amount
    raise NoFundsError, 'Insufficient funds' unless remaining.positive?
    @balance -= amount
    amount
  end

  def add(amount)
    raise ArgumentError unless amount.positive?
    @balance += amount
  end

end