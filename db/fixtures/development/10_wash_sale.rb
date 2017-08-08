# coding: utf-8

srand 1234

id = 1
Place.all.each do |place|
  (1..2).each do |eq_num|
    ((Date.parse('2015/8/1'))..(Date.parse('2017/7/31'))).each do |date, idx|
      sales_count = rand(0..15)
      cash_amount_rate = rand(0..100)
      WashSale.seed do |s|
        s.id = id
        s.place = place
        s.target_date = date
        s.equipment_num = eq_num
        s.sales_count = sales_count
        s.cash_sales_amount = (sales_count * 500) * cash_amount_rate / 100
        s.prepaid_sales_amount = (sales_count * 500) * (100 - cash_amount_rate) / 100
        s.prepaid_sales_point = rand(0..15)
      end
      id += 1
    end
  end
end
