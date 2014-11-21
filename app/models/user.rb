class User < ActiveRecord::Base  
  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  has_many :jobs
  has_and_belongs_to_many  :groups
  has_many :problemsets, through: :groups

  def best
    if Problem.last
      @best = Array.new #max id for problems! CHANGE TO HASHMAP LATER RATHER INNEFICIENT
      Problem.all.each do |p|
          @best << {problem: p, job: self.jobs.where("problem_id = #{p.id}").order("points").last}
      end 
    else
      @best = Array.new(0)
    end
    puts @best
    @best
  end
  
  def get_best(problemid)
    @indbest = nil
    best.each do |b|
      if b[:problem].id == problemid
        @indbest = b[:problem]
      end
    end
    @indbest
  end
  
  def points
    @points = 0
    self.best.each do |p|
      if p && p[:job]
        @points += p[:job].points
      end
    end
    @points
  end
  
  def gpoints(group)
    @points = 0
    #puts group.users.includes(self)
    self.best.each do |p|#problems for user
      if p && p[:job]
        group.problemsets.each do |problemset|#problemSETS for group
          if problemset.problems.exists?(p[:problem])
            @points += p[:job].points
            #puts "from user.rb: "
            #puts p[:job].points
          end
        end
      end
    end
    @points
  end
  
  def jobs_problems
    #unfishished
    @leaderboard = self.users#.sort_by(&:gpoints).reverse
    @data = Array.new
    @leaderboard.each do |user|
      @data << {prob: user.prob, job: user.jobs.where()}
    end
    puts "UNFINISHED DONT KNOW WHAT IT WOULD DO"
  end
  
end
