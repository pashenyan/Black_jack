class Table
  attr_reader :carts
  attr_accessor :money

  def initialize
    @carts = []
    @money = 0
  end

  def add_carts
    people = %w[J Q K A 2 3 4 5 6 7 8 9 10]
    suit = ['†', '♥', '♦', '♣']
    people.each do |x|
      suit.each do |y|
        cart = "#{x}" + "#{y}"
        @carts << cart
      end
    end
  end

  def remove_cart(cart)
    @carts.delete_at(cart)
  end

  def size
    @carts.size
  end

  def add_money(money)
    @money += money
  end
end
