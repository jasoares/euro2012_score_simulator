class Group < ActiveRecord::Base
  has_many :teams
  has_many :scores

  attr_accessible :name, :scores

  def teams_with_points(n)
    teams.select { |t| t.points == n }
  end

  def scores_between(teams)
    scores.select { |s| s.between?(teams) }
  end

  def to_s
    name
  end
end
