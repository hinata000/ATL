class HomesController < ApplicationController

  def index
    today = Date.today

    if [1, 2, 3].include?(today.mon)
      today_season = 4
    elsif [4, 5, 6].include?(today.mon)
      today_season = 1
    elsif [7, 8, 9].include?(today.mon)
      today_season = 2
    elsif [10, 11, 12].include?(today.mon)
      today_season = 3
    end

    @animations = Animation.where(season: today_season, year: today.year)
  end
end
