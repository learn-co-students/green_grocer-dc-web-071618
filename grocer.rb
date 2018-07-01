require "pry"

def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |item|
    item.each do |item_name, cost_hash|
      count = 1
      cost_hash[:count] = count
      if cart_hash[item_name] == nil
        cart_hash[item_name] = cost_hash
      else
        count += 1
        cost_hash[:count] = count
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  if coupons.length == 0
    return cart
  end
  new_cart ={}
  cart.each do |item, cost_hash|
    coupons.each do |coupon|
      if item == coupon[:item]
        new_count = 0
        while cost_hash[:count] >= coupon[:num]
          new_cart["#{item} W/COUPON"] = {:price => coupon[:cost], :clearance => cost_hash[:clearance], :count => new_count += 1}
          cost_hash[:count] -= coupon[:num]
          new_cart[item] = cost_hash
        end
      else
        new_cart[item] = cost_hash
      end
    end
  end
  new_cart
end

cart = {"CHEESE" => {:price => 6.50, :clearance => false, :count => 5}, "AVOCADO" => {:price => 3.0, :clearance => true, :count => 5}}
coupons =[{:item => "CHEESE", :num => 3, :cost => 15.00}, {:item => "AVOCADO", :num => 2, :cost => 5.00}]
result = apply_coupons(cart, coupons)
puts result
puts result["CHEESE"][:price]
puts result["CHEESE W/COUPON"][:price]

def apply_clearance(cart)
  cart.each do |item, cost_hash|
    if cost_hash[:clearance] == true
      clearance_price = 0.8 * cost_hash[:price]
      cost_hash[:price] = clearance_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  total = 0
  cart.each do |item, cost_hash|
    item_cost = cost_hash[:price] * cost_hash[:count]
    total += item_cost
  end
  total
end
