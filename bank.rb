class Bank
  def initialize
    @bet_records = []
  end

  def receive_bet(player, amount)
    raise ArgumentError, "#{player} is not a Player" unless player.is_a? Player
    raise ArgumentError, "Amount should be Numeric" unless amount.is_a? Numeric
    @bet_records << [player, amount]
  end

  def release_win
    amount = @bet_records.map { |row| row[1] }.sum
    reset_bet_records
    amount
  end

  def return_bets
    @bet_records.each do |player, amount|
      player.receive_money(amount)
    end
    reset_bet_records
  end

  private

  def reset_bet_records
    @bet_records = []
  end
end