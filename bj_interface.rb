# frozen_string_literal: true

class BJInterface
  def choose_action(actions)
    puts 'Выберите действие'
    actions.each_with_index do |act_record, index|
      puts [(index + 1).to_s, act_record['message']].join(' ')
    end
    index = gets.chomp
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
    puts "Победил #{winner.name}"
  end

  def play_again?
    actions = [{ 'message' => 'Да', 'action' => true },
               { 'message' => 'Нет', 'action' => false }]
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
    playing = info['playing']
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
    puts "Баланс: #{dealer_balance} | Ставка: #{dealer_bet}"
    puts "Карты: #{dealer_cards} | Очки: #{dealer_value}"
    puts '=' * 50
  end
end
