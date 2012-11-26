class Order < ActiveRecord::Base
#  attr_accessible :title, :body
  has_many :line_items, as: :itemable

#  monetize :total_cents

  def total_cents
    total = 0
    line_items.each do |li|
      total += line_items.total
    end
    total
#     line_items.sum(&:total)
  end


  def bill
    true
    #
    # ### This is where we will build the bill logic
    #
  end

end
