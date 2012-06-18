# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@group_a, @group_b, @group_c, @group_d = Group.create([
  { name: "A" }, { name: "B" }, { name: "C" }, { name: "D"}
])

@cze, @gre, @pol, @rus = Team.create([
  { name: "Czech Rep.", group: @group_a },
  { name: "Greece", group: @group_a },
  { name: "Poland", group: @group_a },
  { name: "Russia", group: @group_a }
])

Score.create([
  { home_team: @pol, away_team: @gre, h_score: 1, a_score: 1, group: @group_a },
  { home_team: @rus, away_team: @cze, h_score: 4, a_score: 1, group: @group_a },
  { home_team: @gre, away_team: @cze, h_score: 1, a_score: 2, group: @group_a },
  { home_team: @pol, away_team: @rus, h_score: 1, a_score: 1, group: @group_a },
  { home_team: @gre, away_team: @rus, h_score: 1, a_score: 0, group: @group_a },
  { home_team: @cze, away_team: @pol, h_score: 1, a_score: 0, group: @group_a }
])

@den, @ger, @net, @por = Team.create([
  { name: "Denmark", group: @group_b },
  { name: "Germany", group: @group_b },
  { name: "Netherlands", group: @group_b },
  { name: "Portugal", group: @group_b }
])

Score.create([
  { home_team: @net, away_team: @den, h_score: 0, a_score: 1, group: @group_b },
  { home_team: @ger, away_team: @por, h_score: 1, a_score: 0, group: @group_b },
  { home_team: @den, away_team: @por, h_score: 2, a_score: 3, group: @group_b },
  { home_team: @net, away_team: @ger, h_score: 1, a_score: 2, group: @group_b },
  { home_team: @den, away_team: @ger, h_score: 1, a_score: 2, group: @group_b },
  { home_team: @por, away_team: @net, h_score: 2, a_score: 1, group: @group_b }
])

@cro, @ita, @roi, @spa = Team.create([
  { name: "Croatia", group: @group_c },
  { name: "Italy", group: @group_c },
  { name: "Rep. of Ireland", group: @group_c },
  { name: "Spain", group: @group_c }
])

Score.create([
  { home_team: @spa, away_team: @ita, h_score: 1, a_score: 1, group: @group_c },
  { home_team: @roi, away_team: @cro, h_score: 1, a_score: 3, group: @group_c },
  { home_team: @ita, away_team: @cro, h_score: 1, a_score: 1, group: @group_c },
  { home_team: @spa, away_team: @roi, h_score: 4, a_score: 0, group: @group_c }
])

@eng, @fra, @swe, @ukr = Team.create([
  { name: "England", group: @group_d },
  { name: "France", group: @group_d },
  { name: "Sweeden", group: @group_d },
  { name: "Ukraine", group: @group_d }
])

Score.create([
  { home_team: @fra, away_team: @eng, h_score: 1, a_score: 1, group: @group_d },
  { home_team: @ukr, away_team: @swe, h_score: 2, a_score: 1, group: @group_d },
  { home_team: @ukr, away_team: @fra, h_score: 0, a_score: 2, group: @group_d },
  { home_team: @swe, away_team: @eng, h_score: 2, a_score: 3, group: @group_d }
])
