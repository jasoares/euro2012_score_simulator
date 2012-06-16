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
    "Czech Republic",
    "Poland",
    "Croatia",
    "Sweeden",
    "Republic of Ireland",
  ]

  DEBUG = FALSE

  def board_stats
    [
      matches,
      wins,
      draws,
      losses,
      goals_for,
      goals_ag,
      goal_dif,
      points
    ]
  end

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
    print "\n#{self.name} vs #{o.name} : " if DEBUG
    return o.points - points unless o.points == points
    print "a " if DEBUG
    tied_teams = group.teams_with_points(self.points)
    scores = group.scores_between(tied_teams)
    return o.points(scores) - points(scores) unless
      o.points(scores) == points(scores) or
      tied_teams.length > 2
    print "b " if DEBUG
    return o.goal_dif(scores) - goal_dif(scores) unless
      o.goal_dif(scores) == goal_dif(scores)
    print "c " if DEBUG
    return o.goals_for(scores) - goals_for(scores) unless
      o.goals_for(scores) == goals_for(scores)
    print "d " if DEBUG
    return o.goal_dif - goal_dif unless o.goal_dif == goal_dif
    print "e " if DEBUG
    return o.goals_for - goals_for unless o.goals_for == goals_for
    print "f " if DEBUG
    return ranking < o.ranking ? -1 : 1
  end

  def ==(o)
    name == o.name
  end
end
