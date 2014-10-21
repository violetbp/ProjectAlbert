json.array!(@problem_completions) do |problem_completion|
  json.extract! problem_completion, :id, :username, :problemname, :score, :previousOutput, :attempt
  json.url problem_completion_url(problem_completion, format: :json)
end
