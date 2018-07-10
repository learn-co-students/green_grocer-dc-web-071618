require 'pry'

def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |hash|
    hash.each do |key, value_hash|
      consolidated_cart[key] = value_hash
      # value_hash[:count] = cart.count(hash)
    end
  end
  consolidated_cart.each do |key, value_hash|
      # binding.pry

    consolidated_cart[key][:count] = cart.count({key => value_hash})
  end

  # binding.pry
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |key, value_hash|
    if value_hash[:clearance]
      value_hash[:price]  = (value_hash[:price]*80).floor/100.00
    end
  end
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart_coupons = apply_coupons(consolidated_cart, coupons)
  consolidated_cart_coupons_clearance = apply_clearance(consolidated_cart_coupons)
  total = 0
  consolidated_cart_coupons_clearance.each do |key, value_hash|
    total += (value_hash[:price]*value_hash[:count])
  end
  if total > 100
    total *= 0.9
  end
  total
end
