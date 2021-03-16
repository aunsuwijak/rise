# FIXME: Make this changable when needed
PRICES = {
  red: 50,
  green: 40,
  blue: 30,
  yellow: 50,
  pink: 80,
  purple: 90,
  orange: 120,
}.freeze

DISCOUNTS = [
  -> (cart) {
    return 5 if (!cart.items[:orange].nil? && cart.items[:orange] >= 2) ||
      (!cart.items[:pink].nil? && cart.items[:pink] >= 2) ||
      (!cart.items[:green].nil? && cart.items[:green] >= 2)
  },
  -> (cart) {
    return 10 if cart.membership
  }
].freeze

class Cart
  attr_accessor :items, :membership

  def initialize
    @items = {}
    @membership = false
  end

  def add(item, quantity)
    if @items[item]
      @items[item] += quantity
    else
      @items[item] = quantity
    end
  end

  def remove(item, quantity)
    if @items[item]
      @items[item] -= quantity

      if @items[item] < 0
        @items[item] = 0
      end
    else
      @items[item] = 0
    end
  end

  def discount
    default_discount = 0
    # FIXME: Make `discount_fn` injectable when required.
    DISCOUNTS.each do |discount_fn|
      default_discount += discount_fn.call(self) || 0
    end
    default_discount
  end
end
