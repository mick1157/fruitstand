class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_cart

  def current_cart
    unless session[:cart_id]
      @cart = Cart.create!
#      logger.debug("cart create is #{@cart.inspect}")
      session[:cart_id] = @cart.id
    else
      @cart = Cart.find(session[:cart_id])
    end #unless

  end #current_cart


end
