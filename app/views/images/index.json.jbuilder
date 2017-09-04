json.array! @images do |image|
  json.id image.id
  json.url image.image.url
  json.shootedAt image.shooted_at
end
