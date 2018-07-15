def consolidate_cart(cart)
  cart.each_with_object({}) do |item, full_cart|
    item.each do |category, traits|
      if full_cart[category]
        traits[:count] += 1
      else
        traits[:count] = 1
        full_cart[category] = traits
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    food = coupon[:item]
    if cart[food] && cart[food][:count] >= coupon[:num]
      if cart["#{food} W/COUPON"]
        cart["#{food} W/COUPON"][:count] += 1
      else
        cart["#{food} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{food} W/COUPON"][:clearance] = cart[food][:clearance]
      end
      cart[food][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |food, info|
    if info[:clearance]
      clearance_price = info[:price] * 0.80
      info[:price] = clearance_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  after_coupons = apply_coupons(consolidated_cart, coupons)
  checkout_cart = apply_clearance(after_coupons)
  final_cost = 0
  checkout_cart.each do |food, info|
    final_cost += info[:price] * info[:count]
  end
  final_cost = final_cost * 0.9 if final_cost > 100
  final_cost
end
