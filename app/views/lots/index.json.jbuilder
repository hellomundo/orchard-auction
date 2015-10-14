json.array!(@lots) do |lot|
  json.extract! lot, :id, :name, :description
  json.url lot_url(lot, format: :json)
end
