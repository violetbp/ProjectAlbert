json.array!(@problems) do |problem|
  json.extract! problem, :id, :title, :explanation, :exIn, :exOut
  json.url problem_url(problem, format: :json)
end
