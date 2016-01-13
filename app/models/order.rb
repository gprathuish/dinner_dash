class Order < ActiveRecord::Base
  has_many :carts, dependent: :destroy
  has_many :items, :through => :carts
  belongs_to :user
	
  enum payment_mode: [:paypal, :active_merchant, :cash_on_delvery]
  enum payment_status: [:payment_pending, :payment_received, :payment_faild]
  enum delivery_status: [:delivery_pending, :delivered, :order_canceled]
  enum order_type: [:under_process, :accepted]
end