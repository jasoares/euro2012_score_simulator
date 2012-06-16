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

  def to_board
    teams.sort!
    header = "\n#{('Group ' + name).ljust(23)}M\tW\tD\tL\tGF\tGA\tGD\tPts\n"
    print header
    teams.each do |t|
      board_line = t.name.ljust(23)
      t.board_stats.each do |stat|
        board_line << "#{stat}\t"
      end
      puts board_line
    end
    puts
    scores.each { |s| puts s }
    nil
  end
end
