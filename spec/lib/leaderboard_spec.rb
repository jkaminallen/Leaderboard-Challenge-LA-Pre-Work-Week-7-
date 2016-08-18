require 'spec_helper'

RSpec.describe Leaderboard do
  describe ".new" do
    it "takes the team's name, rank, wins, and losses as arguments" do
      leader = Leaderboard.new
      expect(leader).to be_a(Leaderboard)
    end
  end

  describe "create_objects" do
    it "creates a team object by iterating through GAME_INFO to create team objects with only their names" do
      expect(Team.new("Patriots")).to be_instance_of(Team)
    end

    it "should create an array" do
      leader = Leaderboard.new
      expect(leader.create_objects).to all(be_a(Team))
      teams = leader.create_objects
      expect(leader.create_objects.size).to eq(4)
    end
  end

  describe "total_wins" do
    it "should add up the number of wins for each team by iterating through GAME_INFO" do
      leader = Leaderboard.new
      patriots = leader.teams.select{ |team| team.name == "Patriots"}[0]
      expect(patriots.wins).to eq(3)
    end
  end

  describe "total_losses" do
    it "should add up the number of losses for each team by iterating through GAME_INFO" do
      leader = Leaderboard.new
      patriots = leader.teams.select{ |team| team.name == "Patriots"}[0]
      expect(patriots.losses).to eq(0)
    end
  end

  describe "sort_rankings" do
    it "should rank and sort the teams in regard to their total wins and losses" do
      leader = Leaderboard.new
      patriots = leader.teams.select{ |team| team.name == "Patriots"}[0]
      expect(patriots.rank).to eq(1)
    end
  end

  describe "ranking_output" do
    it "should print out the leaderboard" do
      leader = Leaderboard.new
      leader.ranking_output
    end
  end
end
