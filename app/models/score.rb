class Score < ActiveRecord::Base
  belongs_to :home_team, :class_name => "Team"
  belongs_to :away_team, :class_name => "Team"
  belongs_to :group
  attr_accessible :home_team, :away_team, :a_score, :h_score, :group

  def against?(teams)
    teams = [teams] if teams.is_a?(Team)
    teams.inject(false) do |v, t|
      v ||= home_team == t || away_team == t
    end
  end

  def between?(teams)
    teams.include?(home_team) && teams.include?(away_team)
  end

  def draw?
    h_score == a_score
  end

  def goals_for(team)
    home_team == team ? h_score : a_score
  end

  def goals_ag(team)
    home_team == team ? a_score : h_score
  end

  def loss?(team)
    winner ? winner != team : false
  end

  def to_s
    "#@home_team #@h_score - #@a_score #@away_team"
  end

  def win?(team)
    winner ? winner == team : false
  end

  def winner
    h_score > a_score ? home_team : h_score < a_score ? away_team : nil
  end

  def ==(o)
    home_team.name == o.home_team.name and
    h_score == o.h_score and
    away_team.name == o.away_team.name and
    a_score == o.a_score
  end
end
