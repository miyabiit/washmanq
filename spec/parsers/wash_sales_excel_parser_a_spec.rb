require 'rails_helper'

describe WashSalesExcelParserA do
  describe "#parse" do
    describe "pattern1.xls" do
      before do
        place = Place.create!(name: 'pattern1', equipment_count: 2)
        place_alias = PlaceAlias.create!(place: place, name: 'テスト小雀')
        xls = Roo::Excelx.new(Rails.root.join('spec', 'data', 'pattern1.xlsx').to_s)
        @sales = WashSalesExcelParserA.parse(xls)
      end
      it do
        expect(@sales.count).to eq(31*2)
      end
    end
  end
end
