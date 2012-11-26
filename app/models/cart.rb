class Cart < ActiveRecord::Base
  # attr_accessible :title, :body

 # The dependent: :destroy -- will delete all the dependent rows from line_items table

  has_many :line_items, as: :itemable, dependent: :destroy

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
