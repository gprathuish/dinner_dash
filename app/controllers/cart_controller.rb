class CartController < ApplicationController
  before_action :authenticate_user, only: :check_out
  
  def index  	
  	@cart_items = Cart.where order_id: current_cart.id    
    respond_to do |format|    
      format.js
    end
  end

  def add_to_cart  	
  	# raise params.inspect
  	Cart.add_item current_cart.id, Item.find(params[:item_id]), params[:value]
 		@cart_items = Cart.where order_id: current_cart.id
  end

  def check_out
    amount = current_cart.carts.map{|x| x.unit * x.price.to_f }.inject(0, :+)
    current_cart.delivery_pending!

    if params[:mode] == "paypal"    
      pay_request = PaypalAdaptive::Request.new      
     	data = {
        "returnUrl" => "http://localhost:3000/orders",
        "requestEnvelope" => {"errorLanguage" => "en_US"},
        "currencyCode"=>"USD",
        "receiverList"=>{"receiver"=>
             [{"email"=>"gprathuis-facilitator@gmail.com", "amount"=>"#{amount}"}]},
        "cancelUrl"=> "http://localhost:3000/orders",
        "actionType"=>"PAY"
        # "ipnNotificationUrl"=> orders_path
      }
      pay_response = pay_request.pay(data)
      current_cart.paypal!

      if pay_response.success?        
        OrderMailer.order_confirmation(current_cart).deliver_later
        current_cart.payment_received!        
        current_cart.accepted!
        order = Order.create(user_id: current_user.id)
        session[:order_id] = order.id
        flash[:success] = "Order Successfully placed..."
        redirect_to pay_response.approve_paypal_payment_url
      else
        current_cart.payment_faild!
        puts pay_response.errors.first['message']
        flash[:danger] = "Opps! something thing went wrong..."
        redirect_to orders_path        
      end
    elsif params[:mode] == "cash_on_delvery"
      OrderMailer.order_confirmation(current_cart).deliver_later
      current_cart.cash_on_delvery!
      current_cart.payment_pending!
      current_cart.accepted!
      order = Order.create(user_id: current_user.id)
      session[:order_id] = order.id      
      flash[:success] = "Order Successfully placed..."
      redirect_to orders_path
    end    
  end
  
  # Clear Cart
  def destroy
  	current_cart.carts.destroy_all
  	redirect_to cart_index_path
  end
end
	