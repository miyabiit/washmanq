class SummaryWithRate
  include ActiveAttr::Model

  attribute :place
  attribute :target_month
  attribute :sales_count
  attribute :sales_count_prev_month_rate
  attribute :sales_count_prev_year_rate
  attribute :sales_amount
  attribute :sales_amount_prev_month_rate
  attribute :sales_amount_prev_year_rate
end
