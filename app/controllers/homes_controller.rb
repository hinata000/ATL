class HomesController < ApplicationController

  def index

    if [1, 2, 3].include?(Date.today.mon)
      current_season = 4
      previous_season = 3
      previous_year = Date.today.last_year
    elsif [4, 5, 6].include?(Date.today.mon)
      current_season = 1
      previous_season = 4
      previous_year = Date.today.year
    elsif [7, 8, 9].include?(Date.today.mon)
      current_season = 2
      previous_season = 1
      previous_year = Date.today.year
    elsif [10, 11, 12].include?(Date.today.mon)
      current_season = 3
      previous_season = 2
      previous_year = Date.today.year
    end

    @current_animations = Animation.where(season: current_season, year: Date.today.year).and(Animation.where.not(syobocal_tid: nil)).limit(6)
    @previous_animations = Animation.where(season: previous_season, year: Date.today.year).and(Animation.where.not(syobocal_tid: nil)).limit(6)

    @tier_lists = TierList.new
  end
end
