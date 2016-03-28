json.array!(@platforms) do |platform|
  json.extract! platform, :id, :title, :target1, :target2, :description, :gain1, :gain2, :picture
  json.url platform_url(platform, format: :json)
end
