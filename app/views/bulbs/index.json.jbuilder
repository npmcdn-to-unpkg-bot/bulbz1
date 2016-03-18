json.array!(@bulbs) do |bulb|
  json.extract! bulb, :id, :user_id, :title, :what, :forwhom, :why, :need, :category, :private
  json.url bulb_url(bulb, format: :json)
end
