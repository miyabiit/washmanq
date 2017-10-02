require 'rails_helper'

describe SalesSummaryCreator do
  describe "#create_or_update" do
    describe "normal case" do
      before do
        @place = Place.create!(name: 'テスト')
        @target_month = '201707'
        @no_target_month = '201706'
        @spray_sale = SprayMonthlySale.create!(place: @place, target_month: @target_month, equipment_num: 1, sales_count: 1, cash_sales_amount: 100, prepaid_sales_amount: 200)
        @spray_sale2 = SprayMonthlySale.create!(place: @place, target_month: @target_month, equipment_num: 2, sales_count: 2, cash_sales_amount: 101, prepaid_sales_amount: 201)
        @spray_sale_no_target = SprayMonthlySale.create!(place: @place, target_month: @no_target_month, equipment_num: 1, sales_count: 1, cash_sales_amount: 200, prepaid_sales_amount: 400)
        @wash_sale = WashSale.create!(place: @place, target_date: Date.new(2017, 7, 1), equipment_num: 1, sales_count: 3, cash_sales_amount: 1000, prepaid_sales_amount: 2000)
        @wash_sale2 = WashSale.create!(place: @place, target_date: Date.new(2017, 7, 1), equipment_num: 2, sales_count: 4, cash_sales_amount: 1001, prepaid_sales_amount: 2001)
        @wash_sale_no_target = WashSale.create!(place: @place, target_date: Date.new(2017, 8, 1), equipment_num: 1, sales_count: 3, cash_sales_amount: 1009, prepaid_sales_amount: 2009)
      end

      it do
        summary = SalesSummaryCreator.create_or_update(@place, '201707')

        expect(summary.place.id).to eq(@place.id)
        expect(summary.target_month).to eq('201707')
        expect(summary.sales_count).to eq(@spray_sale.sales_count + @wash_sale.sales_count + @spray_sale2.sales_count + @wash_sale2.sales_count)
        expect(summary.sales_amount).to eq(@spray_sale.cash_sales_amount + @spray_sale.prepaid_sales_amount + @wash_sale.cash_sales_amount + @wash_sale.prepaid_sales_amount + @spray_sale2.cash_sales_amount + @spray_sale2.prepaid_sales_amount + @wash_sale2.cash_sales_amount + @wash_sale2.prepaid_sales_amount)
      end
    end
  end
end
