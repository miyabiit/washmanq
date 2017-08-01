require 'rails_helper'

describe SalesSummaryCreator do
  describe "#create_or_update" do
    describe "normal case" do
      before do
        @place = Place.create!(name: 'テスト')
        @target_month = '201707'
        @no_target_month = '201706'
        @spray_sale = SpraySale.create!(place: @place, target_month: @target_month, equipment_num: 1, sales_count: 1, cash_sales_amount: 100, prepaid_sales_amount: 200)
        @spray_sale_no_target = SpraySale.create!(place: @place, target_month: @no_target_month, equipment_num: 1, sales_count: 1, cash_sales_amount: 200, prepaid_sales_amount: 400)
        @wash_sale = WashSale.create!(place: @place, target_date: Date.new(2017, 7, 1), equipment_num: 1, sales_count: 3, cash_sales_amount: 1000, prepaid_sales_amount: 2000)
        @wash_sale_no_target = WashSale.create!(place: @place, target_date: Date.new(2017, 8, 1), equipment_num: 1, sales_count: 3, cash_sales_amount: 1009, prepaid_sales_amount: 2009)
      end

      it do
        summary = SalesSummaryCreator.create_or_update(@place, '201707')

        expect(summary.place.id).to eq(@place.id)
        expect(summary.target_month).to eq('201707')
        expect(summary.sales_count).to eq(@spray_sale.sales_count + @wash_sale.sales_count)
        expect(summary.sales_amount).to eq(@spray_sale.cash_sales_amount + @spray_sale.prepaid_sales_amount + @wash_sale.cash_sales_amount + @wash_sale.prepaid_sales_amount)
      end
    end
  end
end
