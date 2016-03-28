json.array!(@apps) do |app|
  json.extract! app, :id, :title, :target, :description, :picture
  json.url app_url(app, format: :json)
end
