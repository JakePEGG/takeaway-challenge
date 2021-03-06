require_relative 'menu'
require_relative 'send_sms'

class Order

attr_reader :food_order, :menu

  def initialize(menu = Menu.new, message= Sendsms.new)
    @menu = menu
    @food_order = []
    @message = message
  end

  def order_food(food, quantity)
    @food_order << {:food => food, :quantity => quantity}
  end

  def print_order
    p @food_order
  end

  def total_cost
    sum = 0
    @food_order.each do |item|
      sum += @menu.menu[item[:food]] * item[:quantity]
    end
    sum
  end

  def correct_cost(price)
    total_cost == price
  end

  def checkout(price)
  raise "Incorrect total cost!" if !correct_cost(price)
  @message.send_message("Order complete! Your food is being prepared and will be with you shortly!")
end
end
