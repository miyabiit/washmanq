class MonthlySale < ApplicationRecord
  extend Enumerize 

  belongs_to :place  

  enumerize :operated_by,  in: %i(system user), default: :system

  def destroy_duplication
    MonthlySale.where(type: type, place: place, target_month: target_month, equipment_num: equipment_num).destroy_all
  end
end
