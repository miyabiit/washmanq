class SalesSummary < ApplicationRecord
  belongs_to :place

  scope :sum_amount_and_count_by_target_month, -> {
    group(:target_month).select("target_month, SUM(sales_count) AS sales_count_sum, SUM(sales_amount) AS sales_amount_sum")
  }
end
