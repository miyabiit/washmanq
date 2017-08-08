class SalesCalculator
  class << self
    def summary_with_rate(target_month_first_date)
      summaries = SalesSummary.where(target_month: target_month_first_date.strftime('%Y%m')).order(place_id: :asc).to_a
      prev_month_summaries = SalesSummary.where(target_month: target_month_first_date.prev_month.strftime('%Y%m')).to_a
      prev_year_summaries = SalesSummary.where(target_month: target_month_first_date.prev_year.strftime('%Y%m')).to_a

      summaries_with_rate = summaries.map {|s| SummaryWithRate.new(target_month: s.target_month, place: s.place, sales_amount: s.sales_amount, sales_count: s.sales_count) }

      summaries_with_rate.each do |s|
        if prev_month_summary = prev_month_summaries.find{|ps| ps.place_id == s.place.id}
          s.sales_count_prev_month_rate = s.sales_count.to_f / prev_month_summary.sales_count.to_f if prev_month_summary.sales_count > 0
          s.sales_amount_prev_month_rate = s.sales_amount.to_f / prev_month_summary.sales_amount.to_f if prev_month_summary.sales_amount > 0
        end
        if prev_year_summary = prev_year_summaries.find{|ps| ps.place_id == s.place.id}
          s.sales_count_prev_year_rate = s.sales_count.to_f / prev_year_summary.sales_count.to_f if prev_year_summary.sales_count > 0
          s.sales_amount_prev_year_rate = s.sales_amount.to_f / prev_year_summary.sales_amount.to_f if prev_year_summary.sales_amount > 0
        end
      end

      summaries_with_rate
    end

    def summary_with_rate_for_transition(place, target_date)
      prev_year_month = target_date.prev_year.next_month
      month_range = prev_year_month.strftime('%Y%m') .. target_date.strftime('%Y%m')
      prev_year_month_range = prev_year_month.prev_year.strftime('%Y%m') .. target_date.prev_year.strftime('%Y%m')

      summaries = SalesSummary.where(place: place, target_month: month_range).order(target_month: :asc).to_a
      prev_year_summaries = SalesSummary.where(place: place, target_month: prev_year_month_range).to_a

      summaries_with_rate = summaries.map {|s| SummaryWithRate.new(target_month: s.target_month, place: s.place, sales_amount: s.sales_amount, sales_count: s.sales_count) }

      summaries_with_rate.each do |s|
        if prev_year_summary = prev_year_summaries.find{|ps| ps.target_month[-2..-1] == s.target_month[-2..-1]}
          s.sales_count_prev_year_rate = s.sales_count.to_f / prev_year_summary.sales_count.to_f if prev_year_summary.sales_count > 0
          s.sales_amount_prev_year_rate = s.sales_amount.to_f / prev_year_summary.sales_amount.to_f if prev_year_summary.sales_amount > 0
        end
        prev_target_month = Time.strptime(s.target_month, '%Y%m').prev_month.strftime('%Y%m')
        if prev_month_summary = summaries.find{|ss| ss.target_month == prev_target_month} || prev_year_summaries.find{|ps| ps.target_month == prev_target_month}
          s.sales_count_prev_month_rate = s.sales_count.to_f / prev_month_summary.sales_count.to_f if prev_month_summary.sales_count > 0
          s.sales_amount_prev_month_rate = s.sales_amount.to_f / prev_month_summary.sales_amount.to_f if prev_month_summary.sales_amount > 0
        end
      end

      summaries_with_rate
    end

    # params: sales ( WashSale | SpraySale )
    def summary_by_equipment(sales)
      sales_by_month = []

      cash_sales = sales.group(:equipment_num).sum(:cash_sales_amount)
      prepaid_sales = sales.group(:equipment_num).sum(:prepaid_sales_amount)
      sales = cash_sales.each do |eq_num, cash_amount|
        sales_by_month << SalesByMonth.new(
          equipment_num: eq_num,
          cash_sales_amount: cash_amount,
          prepaid_sales_amount: prepaid_sales[eq_num]
        )
      end

      sales_by_month
    end
  end
end
