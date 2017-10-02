# coding: utf-8

srand 1234

id = 1
Place.all.each do |place|
  (1..2).each do |eq_num|
    [
     '201508', '201509', '201510', '201511', '201512', '201601', '201602',
     '201603', '201604', '201605', '201606', '201607',
     '201608', '201609', '201610', '201611', '201612', '201701', '201702',
     '201703', '201704', '201705', '201706', '201707'
    ].each do |month|
      sales_count = rand(0..15)
      cash_amount_rate = rand(0..100)
      SprayMonthlySale.seed do |s|
        s.id = id
        s.place = place
        s.target_month = month
        s.equipment_num = eq_num
        s.sales_count = sales_count
        s.cash_sales_amount = (sales_count * 200) * cash_amount_rate / 100
        s.prepaid_sales_amount = (sales_count * 200) * (100 - cash_amount_rate) / 100
      end
      id += 1
    end
  end
end
