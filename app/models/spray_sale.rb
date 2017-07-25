class SpraySale < ApplicationRecord
  belongs_to :place  

  def destroy_duplication
    SpraySale.where(place: place, target_month: target_month, equipment_num: equipment_num).destroy_all
  end
end
