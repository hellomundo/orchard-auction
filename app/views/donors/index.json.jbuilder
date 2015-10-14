json.array!(@donors) do |donor|
  json.extract! donor, :id, :company
  json.url donor_url(donor, format: :json)
end
