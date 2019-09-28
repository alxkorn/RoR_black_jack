# frozen_string_literal: true

class BJInterface
  def choose_action(actions)
    puts 'Выберите действие'
    actions.each_with_index do |act_record, index|
      puts [(index + 1).to_s, act_record['message']].join(' ')
    end
    index = gets.chomp.to_i - 1
    action = actions[index]['action']
    raise InvalidActionError, 'Недопустимое действие' if action.nil?

    action
  end

  def request_name
    puts 'Введите имя:'
    gets.chomp
  end

  def request_action(actions)
    begin
      action = choose_action(actions)
    rescue InvalidActionError => e
      puts e
      retry
    end
    action
  end

  def inform_winner(winner)
    if winner.nil?
      puts 'Ничья'
    else
      puts "Победил #{winner.name}"
    end
  end

  def play_again?
    actions = [{ 'message' => 'Да', 'action' => false }, # это значение пойдет в переменную @end_game
               { 'message' => 'Нет', 'action' => true }]
    begin
      puts 'Сыграть заново?'
      answer = choose_action(actions)
    rescue InvalidActionError => e
      puts e
      retry
    end
    answer
  end

  def show_info(info)
    dealer = info['dealer']
    player = info['player']
    bank = info['bank']
    playing = info['round_playing']
    if playing
      dealer_cards = '*' * dealer.cards.size
      dealer_value = '?'
    else
      dealer_cards = dealer.cards_string
      dealer_value = dealer.hand_value
    end
    dealer_balance = bank.balance_of(dealer)
    dealer_bet = bank.bet_of(dealer)
    player_balance = bank.balance_of(player)
    player_bet = bank.bet_of(player)
    player_cards = player.cards_string
    player_value = player.hand_value
    puts '=' * 50
    puts 'Диллер'
    puts "Баланс: #{dealer_balance} | Ставка: #{dealer_bet}"
    puts "Карты: #{dealer_cards} | Очки: #{dealer_value}"
    puts '-' * 50
    puts player.name
    puts "Баланс: #{player_balance} | Ставка: #{player_bet}"
    puts "Карты: #{player_cards} | Очки: #{player_value}"
    puts '=' * 50
  end
end
