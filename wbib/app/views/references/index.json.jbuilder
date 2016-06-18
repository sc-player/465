json.array!(@references) do |reference|
  json.extract! reference, :id, :URL, :topic, :annotation
  json.url reference_url(reference, format: :json)
end
