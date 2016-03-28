json.array!(@services) do |service|
  json.extract! service, :id, :title, :target, :description, :picture
  json.url service_url(service, format: :json)
end
