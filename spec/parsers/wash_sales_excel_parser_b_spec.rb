require 'rails_helper'

describe WashSalesExcelParserB do
  describe "#parse" do
    describe "pattern4.xlsx" do
      before do
        xls = Roo::Excelx.new(Rails.root.join('spec', 'data', 'pattern4.xlsx').to_s)
        @sales = WashSalesExcelParserB.parse(xls)
      end
      it do
        expect(@sales.count).to eq(31)
        expect(@sales.map(&:target_date).all? {|date| date.month == 5}).to be_truthy
      end
    end
  end
end
