class Player
  def initialize(name)
    @name = name
    @hand = Hand.new
    @bank = Bank.new
  end
end