class Job < ActiveRecord::Base
  belongs_to :problem_completion

  def points
    if self
      if self.graded
        @p = (self.function.to_i + self.style.to_i + self.solution.to_i)
      else
        @p = self.autopoints
      end
    else
      @p = 0
    end
    @p
  end
end
