json.array!(@responses) do |response|
  json.extract! response, :id, :answer_id, :userid
  json.url response_url(response, format: :json)
end
