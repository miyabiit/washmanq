class WashSale < ApplicationRecord
  belongs_to :place  

  has_many :wash_sale_courses, dependent: :destroy

  accepts_nested_attributes_for :wash_sale_courses

  def destroy_duplication
    WashSale.where(place: place, target_date: target_date, equipment_num: equipment_num).destroy_all
  end
end
