namespace :migrate do
  desc 'migrate monthly sales'
  task :monthly_sales => :environment do
    MonthlySale.transaction do
      SpraySale.all.each do |spray_sale|
        monthly_sale = SprayMonthlySale.new(
          place: spray_sale.place,
          target_month: spray_sale.target_month,
          equipment_num: spray_sale.equipment_num,
          cash_sales_amount: spray_sale.cash_sales_amount,
          prepaid_sales_amount: spray_sale.prepaid_sales_amount,
          sales_count: spray_sale.sales_count
        )
        monthly_sale.destroy_duplication
        monthly_sale.save!
      end

      Place.all.each do |place|
        SalesSummary.where(place: place).pluck(:target_month).each do |target_month|
          target_date = Date.strptime(target_month, '%Y%m')
          date_range = (target_date.beginning_of_day .. target_date.end_of_month.end_of_day)

          SalesCalculator.summary_by_equipment(WashSale.where(target_date: date_range, place: place)).each do |sale|
            monthly_sale = WashMonthlySale.new(
              place: place,
              target_month: target_month,
              equipment_num: sale.equipment_num,
              cash_sales_amount: sale.cash_sales_amount,
              prepaid_sales_amount: sale.prepaid_sales_amount,
              sales_count: sale.sales_count
            )
            monthly_sale.destroy_duplication
            monthly_sale.save!
          end
        end
      end
    end
  end
end
