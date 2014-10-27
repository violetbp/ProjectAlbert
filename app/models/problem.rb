class Problem < ActiveRecord::Base

  validates :explanation, presence:true, length: {minimum:1}
  validates :exIn, presence:true, length: {minimum:1}
  validates :exOut, presence:true, length: {minimum:1}
  validates :points, presence:true
  has_many :problem_completions
end
