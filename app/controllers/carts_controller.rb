class CartsController < ApplicationController
  def add
    logger.debug("Session cart is #{session[:cart_id]}")
    unless session[:cart_id]
      @cart = Cart.create!
      logger.debug("cart create is #{@cart.inspect}")
      session[:cart_id] = @cart.id
    else
      @cart = Cart.find(session[:cart_id])
    end
#    logger.debug("Look here ******************************* Cart is #{@cart.inspect}")

    @product = Product.find(params[:product_id])

    if @line_item = @cart.line_items.find_by_product_id(@product)
      @line_item.quantity += 1
    else

#      logger.debug("Look here ******************************* Line Item is #{@line_item.inspect}")

      @line_item = @cart.line_items.new(product: @product, quantity: 1)
    end
    if @line_item.save
#      redirect_to root_path, :flash[notice]  => "Added quantity of 1 to cart.."
      redirect_to root_path, :flash =>  { :info => "Added quantity of 1 to cart.." }

    else
      redirect_to root_path, :flash[:error] => "There was a problem adding to cart.."
    end

  end

  def remove
    @line_item = LineItem.find(params[:line_item_id])
    @line_item.destroy
    redirect_to carts_path, :flash =>  { :info => "Subtracted 1 from cart.." }
  end

  def index
    if session[:cart_id]
     @cart = Cart.find(session[:cart_id])
    else
      flash[notice] = "There is NO cart -- please add to cart first.."
      redirect_to root_path
    end
  end

  def checkout
    @cart = Cart.find(session[:cart_id])

    @order = Order.create!

    @sum_of_cart=0
    @cart.line_items.each do |item|
      sum_of_item = item.quantity * item.price
      @sum_of_cart = @sum_of_cart + sum_of_item
      @order.line_items << LineItem.new({product: item.product, quantity: item.quantity})
    end
    #
    # ### Save the order items to the table
    #
    @order.save
    #
    # ### Bill the order
    #
    if @order.bill

      if OrderMailer.complete(@order).deliver
        flash[notice] = "an email has been sent.."

      end
      #
      # ### After order billed -- clean up the cart
      # ### Please note the dependents - line_items will be deleted - because of dependent: :destroy in model
      #
      if @cart.destroy
        session[:cart_id] = nil
      end

    end



    flash[notice] = "Thank you for completing your order.."
    redirect_to root_path

  end

  def thankyou
  end
end
