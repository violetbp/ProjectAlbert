class Group < ActiveRecord::Base
  has_and_belongs_to_many :problemsets
  has_and_belongs_to_many :users
  
  def get_leaderboard
    @leaderboard = self.users#.sort_by(&:gpoints).reverse
    @leaderhash  = Array.new
    @leaderboard.each do |user|
      @leaderhash << {user: user, pts: user.gpoints(self)}
    end
  end
  
end
