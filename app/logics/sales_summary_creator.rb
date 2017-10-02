class SalesSummaryCreator
  def self.create_or_update(place, target_month, skip_monthly_sales_creation: false)
    target_month = target_month.strftime('%Y%m') if target_month.is_a?(Date)
    place = Place.find(place) if place.is_a?(Integer)

    summary = SalesSummary.find_or_initialize_by(place: place, target_month: target_month)

    spray_sales = SprayMonthlySale.where(target_month: target_month, place: place)
    spray_sales_count = spray_sales.sum(:sales_count)
    spray_sales_amount = spray_sales.sum(:cash_sales_amount) + spray_sales.sum(:prepaid_sales_amount)

    unless skip_monthly_sales_creation
      target_date = Date.strptime(target_month, '%Y%m')
      date_range = (target_date.beginning_of_day .. target_date.end_of_month.end_of_day)

      wash_sales_by_equipment = SalesCalculator.summary_by_equipment(WashSale.where(target_date: date_range, place: place))
      wash_sales_by_equipment.each do |wash_sale|
        wash_monthly_sale = WashMonthlySale.find_or_initialize_by(place: place, target_month: target_month, equipment_num: wash_sale.equipment_num)
        wash_monthly_sale.cash_sales_amount = wash_sale.cash_sales_amount
        wash_monthly_sale.prepaid_sales_amount = wash_sale.prepaid_sales_amount
        wash_monthly_sale.sales_count = wash_sale.sales_count
        wash_monthly_sale.operated_by = :system
        wash_monthly_sale.save!
      end
    end

    wash_sales = WashMonthlySale.where(target_month: target_month, place: place)
    wash_sales_count = wash_sales.sum(:sales_count)
    wash_sales_amount = wash_sales.sum(:cash_sales_amount) + wash_sales.sum(:prepaid_sales_amount)

    summary.update_attributes(
      sales_count: spray_sales_count + wash_sales_count,
      sales_amount: spray_sales_amount + wash_sales_amount
    )

    summary
  end
end
