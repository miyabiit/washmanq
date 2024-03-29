require 'rails_helper'

describe WashSalesExcelParserA do
  describe "#parse" do
    describe "pattern1.xlsx" do
      before do
        xls = Roo::Excelx.new(Rails.root.join('spec', 'data', 'pattern1.xlsx').to_s)
        @sales = WashSalesExcelParserA.parse(xls)
      end
      it do
        expect(@sales.count).to eq(31*2)
        expect(@sales.map(&:target_date).all? {|date| date.month == 5}).to be_truthy
      end
    end
  end
end
