require_relative 'cart'

class Calculator
  def self.caculate_total(cart)
    total = 0
    cart.items.each do |item, quantity|
      total += PRICES[item] * quantity
    end
    total * (1 - cart.discount / 100.0)
  end
end
