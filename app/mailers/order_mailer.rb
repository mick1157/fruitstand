class OrderMailer < ActionMailer::Base
  default from: "from@example.com"

  def complete(order)
    @order = order
    mail(to: "mick1157@gmail.com", subject: "Your order was successfully completed")
  end

end
