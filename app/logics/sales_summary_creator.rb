class SalesSummaryCreator
  def self.create_or_update(place, target_month)
    target_month = target_month.strftime('%Y%m') if target_month.is_a?(Date)
    place = Place.find(place) if place.is_a?(Integer)

    summary = SalesSummary.find_or_initialize_by(place: place, target_month: target_month)

    spray_sales = SpraySale.where(target_month: target_month, place: place)
    spray_sales_count = spray_sales.sum(:sales_count)
    spray_sales_amount = spray_sales.sum(:cash_sales_amount) + spray_sales.sum(:prepaid_sales_amount)

    target_date = Date.strptime(target_month, '%Y%m')
    date_range = (target_date.beginning_of_day .. target_date.end_of_month.end_of_day)

    wash_sales = WashSale.where(target_date: date_range, place: place)
    wash_sales_count = wash_sales.sum(:sales_count)
    wash_sales_amount = wash_sales.sum(:cash_sales_amount) + wash_sales.sum(:prepaid_sales_amount)

    summary.update_attributes(
      sales_count: spray_sales_count + wash_sales_count,
      sales_amount: spray_sales_amount + wash_sales_amount
    )

    summary
  end
end
