id = 1
%W(小雀 伊勢原 センター北 藤沢 大和桜ケ丘).each_with_index do |name, idx|
  PlaceAlias.seed(:id) do |s|
    s.id = id
    s.place_id = idx + 1
    s.name = "ウォッシュマンＱ#{name}"
  end
  id += 1
  PlaceAlias.seed(:id) do |s|
    s.id = id
    s.place_id = idx + 1
    s.name = "#{name}店スプレー売上"
  end
  id += 1
  PlaceAlias.seed(:id) do |s|
    s.id = id
    s.place_id = idx + 1
    s.name = name
  end
  id += 1
  PlaceAlias.seed(:id) do |s|
    s.id = id
    s.place_id = idx + 1
    s.name = "#{name}店"
  end
  id += 1
end

PlaceAlias.seed(:id) do |s|
  s.id = id
  s.place_id = 5
  s.name = "大和桜ヶ丘"
end
id += 1
PlaceAlias.seed(:id) do |s|
  s.id = id
  s.place_id = 5
  s.name = "ウォッシュマンＱ大和"
end
id += 1
PlaceAlias.seed(:id) do |s|
  s.id = id
  s.place_id = 5
  s.name = "大和"
end
id += 1
PlaceAlias.seed(:id) do |s|
  s.id = id
  s.place_id = 5
  s.name = "大和店"
end
id += 1
PlaceAlias.seed(:id) do |s|
  s.id = id
  s.place_id = 5
  s.name = "大和店スプレー売上"
end
id += 1
