class LineItem < ActiveRecord::Base
  attr_accessible :price, :product, :quantity

  belongs_to :product
  belongs_to :cart

#  belongs_to :itemable polymorphic:true

  before_create :save_price

  monetize :total_cents, :allow_nil => true

  def total_cents
    if quantity && price
      return quantity * price
    else
      return 0
    end
  end

  private

  def save_price
    self.price = product.price
  end

end
