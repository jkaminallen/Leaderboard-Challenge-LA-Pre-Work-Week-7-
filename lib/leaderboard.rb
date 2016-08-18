require_relative "../spec/spec_helper"

class Leaderboard
  GAME_INFO = [
      {
        home_team: "Patriots",
        away_team: "Broncos",
        home_score: 17,
        away_score: 13
      },
      {
        home_team: "Broncos",
        away_team: "Colts",
        home_score: 24,
        away_score: 7
      },
      {
        home_team: "Patriots",
        away_team: "Colts",
        home_score: 21,
        away_score: 17
      },
      {
        home_team: "Broncos",
        away_team: "Steelers",
        home_score: 11,
        away_score: 27
      },
      {
        home_team: "Steelers",
        away_team: "Patriots",
        home_score: 24,
        away_score: 31
      }
  ]

  attr_reader :teams

  def initialize
    @teams = create_objects
    total_wins
    total_losses
    sort_rankings
  end

  def create_objects
    [Team.new(GAME_INFO[0][:home_team]), Team.new(GAME_INFO[1][:home_team]), Team.new(GAME_INFO[3][:away_team]), Team.new(GAME_INFO[1][:away_team])]
  end

  def total_wins
    GAME_INFO.each do |game|
      home_team = teams.select{ |x| x.name == game[:home_team]}.first
      away_team = teams.select{ |x| x.name == game[:away_team]}.first
      if game[:home_score] > game[:away_score]
        home_team.wins += 1
      else game[:away_score] > game[:home_score]
        away_team.wins += 1
      end
    end
  end

  def total_losses
    GAME_INFO.each do |game|
      home_team = teams.select{ |x| x.name == game[:home_team]}.first
      away_team = teams.select{ |x| x.name == game[:away_team]}.first
      if game[:home_score] < game[:away_score]
        home_team.wins += 1
      else game[:away_score] < game[:home_score]
        away_team.wins += 1
      end
    end
  end

  def sort_rankings
    teams.sort_by { |x| [x.wins, x.losses] }
      teams.each_with_index { |x, i|
        x.rank = i + 1
      }
  end

  def ranking_output
    puts "--------------------------------------------------"
    puts "| Name      Rank      Total Wins    Total Losses |"
      teams.each do |x|
        puts "| " + '%-12s' % x.name + '%-14s' % x.rank + '%-14s' % x.wins + '%-6s' % x.losses + " | "
      end
    puts "--------------------------------------------------"
  end
end
