json.array!(@answers) do |answer|
  json.extract! answer, :id, :answer, :poll_id
  json.url answer_url(answer, format: :json)
end
