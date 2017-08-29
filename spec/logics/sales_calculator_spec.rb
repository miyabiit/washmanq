require 'rails_helper'

describe SalesCalculator do
  describe '#summary_with_rate' do
    before do
      @places = (1..2).map{|i| Place.create!(name: "テスト#{i}") }
      @summaries = [
        SalesSummary.create!(place: @places[0], target_month: '201607', sales_count: 1, sales_amount: 100),
        SalesSummary.create!(place: @places[0], target_month: '201705', sales_count: 2, sales_amount: 101),
        SalesSummary.create!(place: @places[0], target_month: '201706', sales_count: 3, sales_amount: 102),
        SalesSummary.create!(place: @places[0], target_month: '201707', sales_count: 4, sales_amount: 103),
        SalesSummary.create!(place: @places[1], target_month: '201707', sales_count: 5, sales_amount: 104)
      ]
    end

    it do
      summaries, all_summary = SalesCalculator.summary_with_rate(Date.new(2017, 7, 1))
      expect(summaries.count).to eq(2)
      expect(summaries.first.place.id).to eq(@places[0].id)
      expect(summaries.first.target_month).to eq('201707')
      expect(summaries.first.sales_count).to eq(4)
      expect(summaries.first.sales_count_prev_year_rate).to eq(4.0)
      expect(summaries.first.sales_count_prev_month_rate).to eq(4.0 / 3.0)
      expect(summaries.first.sales_amount).to eq(103)
      expect(summaries.first.sales_amount_prev_year_rate).to eq(103.0 / 100.0)
      expect(summaries.first.sales_amount_prev_month_rate).to eq(103.0 / 102.0)

      expect(summaries.last.place.id).to eq(@places[1].id)
      expect(summaries.last.target_month).to eq('201707')
      expect(summaries.last.sales_count).to eq(5)
      expect(summaries.last.sales_count_prev_year_rate).to be_nil
      expect(summaries.last.sales_count_prev_month_rate).to be_nil
      expect(summaries.last.sales_amount).to eq(104)
      expect(summaries.last.sales_amount_prev_year_rate).to be_nil
      expect(summaries.last.sales_amount_prev_month_rate).to be_nil

      expect(all_summary.target_month).to eq('201707')
      expect(all_summary.sales_count).to eq(4 + 5)
      expect(all_summary.sales_amount).to eq(103 + 104)
      expect(all_summary.sales_count_prev_year_rate).to eq(9.0 / 1.0)
      expect(all_summary.sales_count_prev_month_rate).to eq(9.0 / 3.0)
      expect(all_summary.sales_amount_prev_year_rate).to eq(207.0 / 100.0)
      expect(all_summary.sales_amount_prev_month_rate).to eq(207.0 / 102.0)
    end
  end

  describe '#summary_with_rate_for_transition' do
    before do
      @places = (1..2).map{|i| Place.create!(name: "テスト#{i}") }
      other_place_sumamry = SalesSummary.create!(place: Place.create!(name: '対象外'), 
                                                 target_month: '201707', sales_count: 11, sales_amount: 111)
      start_date = Date.new(2016, 7, 1)
      @summaries = (0..13).map {|i|
        SalesSummary.create!(place: @places[0], target_month: start_date.since(i.month).strftime('%Y%m'),
                             sales_count: 1*(i+1), sales_amount: 100*(i+1))
      }
      start_date = start_date.prev_year
      @prev_year_summaries = @summaries.take(12).map.with_index {|s, i|
        SalesSummary.create!(place: s.place, target_month: start_date.since(i.month).strftime('%Y%m'),
                            sales_count: 10*(i+1), sales_amount: 200*(i+1))
      }
    end

    it do
      summaries = SalesCalculator.summary_with_rate_for_transition(@places[0], Date.new(2017, 8, 1)).to_a
      expect(summaries.count).to eq(14)
      expect(summaries.last.place.id).to eq(@places[0].id)
      expect(summaries.last.target_month).to eq('201708')
      expect(summaries.last.sales_count).to eq(1*14)
      expect(summaries.last.sales_count_prev_year_rate).to eq(14.0 / 2.0)
      expect(summaries.last.sales_count_prev_month_rate).to eq(14.0 / 13.0)
      expect(summaries.last.sales_amount).to eq(100*14)
      expect(summaries.last.sales_amount_prev_year_rate).to eq(1400.0 / 200.0)
      expect(summaries.last.sales_amount_prev_month_rate).to eq(14.0 / 13.0)

      expect(summaries.first.place.id).to eq(@places[0].id)
      expect(summaries.first.target_month).to eq('201607')
      expect(summaries.first.sales_count).to eq(1)
      expect(summaries.first.sales_count_prev_year_rate).to eq(1.0 / 10.0)
      expect(summaries.first.sales_count_prev_month_rate).to eq(1.0 / 120.0)
      expect(summaries.first.sales_amount).to eq(100)
      expect(summaries.first.sales_amount_prev_year_rate).to eq(0.5)
      expect(summaries.first.sales_amount_prev_month_rate).to eq(100.0 / (200.0*12))
    end
  end

  describe '#summary_by_equipment' do
    before do
      @place = Place.create!(name: 'テスト')
      @target_month = '201707'
      @no_target_month = '201706'
      @spray_sales = [
        SpraySale.create!(place: @place, target_month: @target_month, equipment_num: 1, sales_count: 1, cash_sales_amount: 100, prepaid_sales_amount: 200),
        SpraySale.create!(place: @place, target_month: @target_month, equipment_num: 2, sales_count: 2, cash_sales_amount: 101, prepaid_sales_amount: 201)
      ]
      @wash_sales = [
        WashSale.create!(place: @place, target_date: Date.new(2017, 7, 1), equipment_num: 1, sales_count: 3, cash_sales_amount: 1000, prepaid_sales_amount: 2000),
        WashSale.create!(place: @place, target_date: Date.new(2017, 7, 31), equipment_num: 1, sales_count: 4, cash_sales_amount: 1001, prepaid_sales_amount: 2001),
        WashSale.create!(place: @place, target_date: Date.new(2017, 7, 1), equipment_num: 2, sales_count: 5, cash_sales_amount: 1003, prepaid_sales_amount: 2003),
      ]
    end

    it do
      wash_sales_summaries = SalesCalculator.summary_by_equipment(WashSale.all)
      spray_sales_summaries = SalesCalculator.summary_by_equipment(SpraySale.all)

      expect(wash_sales_summaries.count).to eq(2)
      expect(wash_sales_summaries.first.equipment_num).to eq(1)
      expect(wash_sales_summaries.first.cash_sales_amount).to eq(1000 + 1001)
      expect(wash_sales_summaries.first.prepaid_sales_amount).to eq(2000 + 2001)
      expect(wash_sales_summaries.last.equipment_num).to eq(2)
      expect(wash_sales_summaries.last.cash_sales_amount).to eq(1003)
      expect(wash_sales_summaries.last.prepaid_sales_amount).to eq(2003)

      expect(spray_sales_summaries.count).to eq(2)
      expect(spray_sales_summaries.first.equipment_num).to eq(1)
      expect(spray_sales_summaries.first.cash_sales_amount).to eq(100)
      expect(spray_sales_summaries.first.prepaid_sales_amount).to eq(200)
      expect(spray_sales_summaries.last.equipment_num).to eq(2)
      expect(spray_sales_summaries.last.cash_sales_amount).to eq(101)
      expect(spray_sales_summaries.last.prepaid_sales_amount).to eq(201)
    end
  end

  describe '#all_summary_with_rate_for_transition' do
    before do
      @places = (1..2).map{|i| Place.create!(name: "テスト#{i}") }
      other_place_sumamry = SalesSummary.create!(place: Place.create!(name: '対象'), 
                                                 target_month: '201708', sales_count: 11, sales_amount: 111)
      start_date = Date.new(2016, 7, 1)
      @summaries = (0..13).map {|i|
        SalesSummary.create!(place: @places[rand(2)], target_month: start_date.since(i.month).strftime('%Y%m'),
                             sales_count: 1*(i+1), sales_amount: 100*(i+1))
      }
      start_date = start_date.prev_year
      @prev_year_summaries = @summaries.take(12).map.with_index {|s, i|
        SalesSummary.create!(place: s.place, target_month: start_date.since(i.month).strftime('%Y%m'),
                            sales_count: 10*(i+1), sales_amount: 200*(i+1))
      }
    end

    it do
      summaries = SalesCalculator.all_summary_with_rate_for_transition(Date.new(2017, 8, 1)).to_a
      expect(summaries.count).to eq(14)
      expect(summaries.last.target_month).to eq('201708')
      expect(summaries.last.sales_count).to eq(1*14 + 11)
      expect(summaries.last.sales_count_prev_year_rate).to eq(25.0 / 2.0)
      expect(summaries.last.sales_count_prev_month_rate).to eq(25.0 / 13.0)
      expect(summaries.last.sales_amount).to eq(100*14 + 111)
      expect(summaries.last.sales_amount_prev_year_rate).to eq(1511.0 / 200.0)
      expect(summaries.last.sales_amount_prev_month_rate).to eq(1511.0 / 1300.0)

      expect(summaries.first.target_month).to eq('201607')
      expect(summaries.first.sales_count).to eq(1)
      expect(summaries.first.sales_count_prev_year_rate).to eq(1.0 / 10.0)
      expect(summaries.first.sales_count_prev_month_rate).to eq(1.0 / 120.0)
      expect(summaries.first.sales_amount).to eq(100)
      expect(summaries.first.sales_amount_prev_year_rate).to eq(0.5)
      expect(summaries.first.sales_amount_prev_month_rate).to eq(100.0 / (200.0*12))
    end
  end
end
