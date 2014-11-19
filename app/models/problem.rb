class Problem < ActiveRecord::Base
  before_create :default_values
  
  validates :title, presence:true, length: {minimum:1}
  validates :explanation, presence:true, length: {minimum:1}
  validates :points, presence:true
  has_and_belongs_to_many :problemsets
  
  private
    def default_values
      exIn = " "
      exOut = " "
    end
end
