class SalesByMonth
  include ActiveAttr::Model

  attribute :equipment_num
  attribute :sales_count
  attribute :cash_sales_amount
  attribute :prepaid_sales_amount
end
