def consolidate_cart(cart)
  # code here
  cart.each_with_object({}) do |item, value|
    item.each do |name, attribute|
      if value[name]
        attribute[:count] += 1
      else
        value[name] = attribute
        attribute[:count] = 1
      end
    end
  end
end

def apply_coupons(cart, coupons)
  # code here
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
  # code here
  cart.each do |name, attribute|
     if attribute[:clearance]
       new_price = attribute[:price] * 0.80
       attribute[:price] = new_price.round(2)
     end
   end
   cart
 end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  result = 0
  final_cart.each do |name, attribute|
    result += (attribute[:price]*attribute[:count]).to_f
  end
  result = result * 0.9 if result > 100
  result
end
