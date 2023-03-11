class Gamer
  attr_reader :carts, :bank
  attr_accessor :summa

  def initialize
    @carts = []
    @summa = 0
    @bank = 100
  end

  def get_cart(cart)
    @carts << cart
  end

  def show_carts
    puts @carts
  end

  def calc
    @carts[2].chr == 'Q' || @carts[2].chr == 'K' || @carts[2].chr == 'J' || @carts[2].chr == '1'
  end

  def sum_calculating_first_round
    @carts.size.times do |x|
      @summa += if @carts[x].chr == 'Q' || @carts[x].chr == 'K' || @carts[x].chr == 'J' || @carts[x].chr == '1'
                  10
                elsif @carts[x].chr == 'A'
                  11
                else
                  @carts[x].chr.to_i
                end
    end

    return unless @summa == 22

    @summa = 10
  end

  def sum_calculating_second_round
    if @summa < 11
      @summa +=
        if calc
          10
        elsif @carts[2].chr == 'A'
          11
        else
          @carts[2].chr.to_i
        end
    end

    return unless @summa > 10

    if calc
      @summa += 10
    elsif @carts[2].chr == 'A'
      @summa -= 1
    else
      @summa += @carts[2].chr.to_i
    end
  end

  def plus_bank(bet)
    @bank += bet
  end

  def minus_bank(bet)
    @bank -= bet
  end

  def size
    @carts.size
  end
end
