class WashSale < ApplicationRecord
  belongs_to :place  

  has_many :wash_sale_courses, dependent: :destroy

  accepts_nested_attributes_for :wash_sale_courses
end
