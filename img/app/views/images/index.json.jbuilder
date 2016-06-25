json.array!(@images) do |image|
  json.extract! image, :id, :filename, :public
  json.url image_url(image, format: :json)
end
