json.array!(@shops) do |shop|
  json.extract! shop, :id, :title, :target, :description, :picture
  json.url shop_url(shop, format: :json)
end
