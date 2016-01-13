class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_confirmation.subject
  #
  def order_confirmation order
    @order = order
    @items = order.carts.includes(:item)
    @total = @items.map{|x| x.unit*x.price.to_f}.inject(0,:+)
    @user = User.find(order.user_id)

    mail to: @user.email, subject: "Dinner Dash: Order Placed Successfuly"
  end


  def registraion_confirmation user
		@user = user
		mail to: @user.email, subject: "Dinner Dash: Registered Successfuly"
  end
end
