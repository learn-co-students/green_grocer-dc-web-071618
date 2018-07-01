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
  new_cart ={}
  cart.each do |item, cost_hash|
    coupons.each do |coupon|
      if item == coupon[:item] && cost_hash[:count] >= coupon[:num]
        cost_hash[:count] = cost_hash[:count] - coupon[:num]
        new_cart[item] = cost_hash
        coupon_cost_hash ={}
        coupon_cost_hash[:price] = coupon[:cost]
        coupon_cost_hash[:clearance] = cost_hash[:clearance]
        coupon_cost_hash[:count] = 1
        new_cart["#{item} W/COUPON"] = coupon_cost_hash
      end
    end
  end
  new_cart
end

cart = {"CHEESE" => {:price => 6.50, :clearance => false, :count => 3}}
coupons =[{:item => "CHEESE", :num => 3, :cost => 15.00}]
puts apply_coupons(cart, coupons)

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
