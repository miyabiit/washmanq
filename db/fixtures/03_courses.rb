(1..20).each do |id|
  Course.seed(:id) do |s|
    s.id = id
    s.basic_price = 0 
    s.special_price = 0 
  end
end
