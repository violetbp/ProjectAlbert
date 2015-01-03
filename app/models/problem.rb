class Problem < ActiveRecord::Base
  before_create :default_values
  
  validates :title, presence:true, length: {minimum:1}
  validates :explanation, presence:true, length: {minimum:1}
  validates :points, presence:true
  has_and_belongs_to_many :problemsets
  
  def type?(type)
    puts type
    puts self.grading_type
    if self.grading_type == type
      true 
    else 
      false 
    end
  end
  
  private
    def default_values
      exIn  = " "
      exOut = " "
    end
end
