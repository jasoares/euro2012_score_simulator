class Team < ActiveRecord::Base
  belongs_to :group
  has_many :home_scores,
           :class_name => "Score",
           :foreign_key => "home_team_id"
  has_many :away_scores,
           :class_name => "Score",
           :foreign_key => "away_team_id"
  attr_accessible :name, :group

  UEFA_RANKING = [
    "England",
    "Spain",
    "Germany",
    "Italy",
    "Portugal",
    "France",
    "Russia",
    "Netherlands",
    "Ukraine",
    "Greece",
    "Denmark",
    "Czech Rep.",
    "Poland",
    "Croatia",
    "Sweeden",
    "Rep. of Ireland",
  ]

  def draws(scores=self.scores)
    scores.count { |s| s.draw? }
  end

  def goal_dif(scores=self.scores)
    goals_for(scores) - goals_ag(scores)
  end

  def goals_ag(scores=self.scores)
    scores.inject(0) { |sum, s| sum += s.goals_ag(self) }
  end

  def goals_for(scores=self.scores)
    scores.inject(0) { |sum, s| sum += s.goals_for(self) }
  end

  def flag_img
    "#{name.downcase.gsub(" ", "_").gsub(".", "")}.gif"
  end

  def losses(scores=self.scores)
    scores.count { |s| s.loss?(self) }
  end

  def matches(scores=self.scores)
    scores.length
  end

  def points(scores=self.scores)
    scores.inject(0) do |pts, s|
      pts += s.win?(self) ? 3 : s.loss?(self) ? 0 : 1
    end
  end

  def ranking
    UEFA_RANKING.index(name)
  end

  def scores
    home_scores + away_scores
  end

  def to_s
    self.name
  end

  def wins(scores=self.scores)
    scores.count { |s| s.win?(self) }
  end

  def <=>(o)
    return o.points - points unless o.points == points
    tied_teams = group.teams_with_points(self.points)
    scores = group.scores_between(tied_teams)
    return o.points(scores) - points(scores) unless
      o.points(scores) == points(scores) or
      tied_teams.length > 2
    return o.goal_dif(scores) - goal_dif(scores) unless
      o.goal_dif(scores) == goal_dif(scores)
    return o.goals_for(scores) - goals_for(scores) unless
      o.goals_for(scores) == goals_for(scores)
    return o.goal_dif - goal_dif unless o.goal_dif == goal_dif
    return o.goals_for - goals_for unless o.goals_for == goals_for
    return ranking < o.ranking ? -1 : 1
  end

  def ==(o)
    name == o.name
  end
end
