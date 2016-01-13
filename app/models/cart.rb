class Cart < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  before_create :update_price

  def update_price
  	self.price = item.price
  	self.unit = 1
  end

  def self.add_item id, item, value = nil
  	record = self.find_by(order_id: id, item_id: item.id)

    if record.present?
      if value == nil     
        record.update(unit: record.unit+1)
      else
        record.update(unit: record.unit+value.to_i)
      end
      if record.unit < 1
        record.delete
      end

    else
      self.create(order_id: id, item_id: item.id, price: item.price, unit: 1) 
    end
  	# if record.present?
   #    if update == "inc"
   #      increment_by = +1
   #    elsif update == "dec"
   #      increment_by = -1
   #    end
   #    increment_by ||= 1
  	# 	record.update(unit: record.unit+increment_by)
   #    if record.unit < 1
   #      record.delete
   #    end

  	# else
  	# 	self.create(order_id: id, item_id: item.id, price: item.price, unit: 1)	
  	# end
  end
end
