class Place < ApplicationRecord
  has_many :place_aliases
  has_many :sales_summaries
  
  class << self
    def find_by_alias_name(name)
      PlaceAlias.find_by(name: name)&.place
    end
  end
end
