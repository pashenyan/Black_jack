require_relative 'table'
require_relative 'gamers'
require 'byebug'
class Main
  def initialize; end

  def start
    print 'Hello, enter your name: '
    name = gets.chomp.capitalize
    puts "Hello, #{name}"
    @player = Gamer.new
    @dealer = Gamer.new
    @table = Table.new

    loop do
      print 'Press enter to start'
      gets
      @table.add_carts
      2.times { cart_to_gamer(@player) }
      2.times { cart_to_gamer(@dealer) }
      beti
      round
      decision
      result
      question
    end
  end

  def cart_to_gamer(gamer)
    cart = rand(0..@table.size - 1)
    gamer.get_cart(@table.carts[cart])
    @table.remove_cart(cart)
  end

  def beti
    print "Enter your bet (max: #{@player.bank}): "
    bet = gets.chomp.to_i
    if (1..@player.bank).include?(bet)
      @table.add_money(bet)
      @player.minus_bank(bet)

      bet2 = rand(1..@dealer.bank)
      @dealer.minus_bank(bet2)
      @table.add_money(bet2)
      puts "Your bet is #{bet}$, dealet bet is #{bet2}$, Bank: #{@table.money}"
    else
      puts "Wrong amount. Enter from 1 to #{@player.bank}"
      beti
    end
  end

  def round
    puts 'Dealers carts: *, *'
    puts "Your carts: #{@player.carts}"
    @player.sum_calculating_first_round
    @dealer.sum_calculating_first_round
    puts "Sum is #{@player.summa}"
  end

  def decision
    print 'Do you want to take cart?((Y)/(N)-open carts/(S)-skip): '
    dec = gets.chomp.upcase
    if dec == 'Y'
      cart_to_gamer(@player)
      @player.sum_calculating_second_round
      logica_dealer
    elsif dec == 'N'
    elsif dec == 'S'
      logica_dealer
    else
      puts 'Unknown command'
      decision
    end
  end

  def logica_dealer
    return unless @dealer.summa <= 17 && @dealer.size == 2

    cart_to_gamer(@dealer)
    @dealer.sum_calculating_second_round
  end

  def result
    puts "Dealer carts: #{@dealer.carts}"
    puts "Dealer sum is: #{@dealer.summa}"

    puts "Your carts: #{@player.carts}"
    puts "Your sum is: #{@player.summa}"

    if @player.summa > @dealer.summa && @player.summa <= 21 || @dealer.summa > 21 && @player.summa <= 21
      player_win

    elsif @dealer.summa > @player.summa && @dealer.summa <= 21 || @dealer.summa <= 21 && @player.summa > 21
      comp_win

    elsif @dealer.summa == @player.summa || @dealer.summa > 21 && @player.summa > 21
      puts 'Blaw'
      @player.plus_bank(@table.money / 2)
      @dealer.plus_bank(@table.money / 2)
      @table.bank = 0
    end
  end

  def question
    print 'Do you want to play again?(Y/N): '
    dec = gets.chomp.upcase
    if dec == 'Y'
      @dealer.carts.clear
      @player.carts.clear
      @dealer.summa = 0
      @player.summa = 0
    elsif dec == 'N'
      exit
    else
      puts 'Unknow command'
      question
    end
  end

  def player_win
    @player.plus_bank(@table.money)
    puts "You win. Your bank: #{@player.bank}"
    @table.money = 0
  end

  def comp_win
    @dealer.plus_bank(@table.money)
    puts "You lose. Your bank: #{@player.bank}"
    @table.money = 0

    return unless @player.bank <= 0

    puts 'You lost your money. Game over'
    exit
  end
end
