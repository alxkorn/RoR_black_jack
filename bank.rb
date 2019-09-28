# frozen_string_literal: true

class Bank
  def initialize
    @bet_records = []
    @balances = []
  end

  def balance_of(player)
    player = find_player(player)
    player.balance
  end

  def register_player(player, balance)
    raise ArgumentError, 'player should be of type Player' unless player.is_a? Player

    @balances << PlayerBalance.new(player, balance)
  end

  def receive_bet(player, amount)
    raise ArgumentError, "#{player} is not a Player" unless player.is_a? Player
    raise ArgumentError, 'Amount should be Numeric' unless amount.is_a? Numeric

    player_record = find_player(player)
    @bet_records << [player_record, player_record.give_money(amount)]
  end

  def release_win(winner)
    if winner.nil?
      return_bets
    else
      player_record = find_player(winner)
      amount = @bet_records.map { |row| row[1] }.sum
      player_record.receive_money(amount)
      reset_bet_records
    end
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

  def find_player(player)
    player_record = @balances.find { |pr| pr.player == player }
    raise PlayerNotFoundError if player_record.nil?

    player_record
  end
end
