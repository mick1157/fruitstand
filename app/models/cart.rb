class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items




  monetize :total_cents


  def total_cents
    total = 0
    line_items.each do |li|
      total += line_items.total
    end
    total
#     line_items.sum(&:total)
  end


end
