class Product < ActiveRecord::Base
  attr_accessible :name, :price

  has_many :line_items

  validates :name, presence: true, :uniqueness => true  # mrt
  validates :price, presence: true,  :numericality => true # mrt




end
