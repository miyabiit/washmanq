require 'rails_helper'

describe SpraySalesExcelParser do
  describe "#parse" do
    describe "pattern2.xlsx" do
      before do
        place = Place.create!(name: 'pattern2', equipment_count: 2)
        place_alias = PlaceAlias.create!(place: place, name: '伊勢原')
        xls = Roo::Excelx.new(Rails.root.join('spec', 'data', 'pattern2.xlsx').to_s)
        @sales = SpraySalesExcelParser.parse(xls)
      end
      it do
        expect(@sales.count).to eq(24)
      end
    end
  end
end
