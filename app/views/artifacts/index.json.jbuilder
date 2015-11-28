json.array!(@artifacts) do |artifact|
  json.extract! artifact, :id, :user, :msg
  json.url artifact_url(artifact, format: :json)
end
