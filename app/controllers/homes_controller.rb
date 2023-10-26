class HomesController < ApplicationController

  def index

    if [1, 2, 3].include?(Time.zone.today.mon)
      current_season = 4
      previous_season = 3
      previous_year = Time.zone.today.last_year
    elsif [4, 5, 6].include?(Time.zone.today.mon)
      current_season = 1
      previous_season = 4
      previous_year = Time.zone.today.year
    elsif [7, 8, 9].include?(Time.zone.today.mon)
      current_season = 2
      previous_season = 1
      previous_year = Time.zone.today.year
    elsif [10, 11, 12].include?(Time.zone.today.mon)
      current_season = 3
      previous_season = 2
      previous_year = Time.zone.today.year
    end

    @current_animations = Animation.where(season: current_season, year: Time.zone.today.year).and(Animation.where.not(syobocal_tid: nil)).limit(6)
    @previous_animations = Animation.where(season: previous_season, year: Time.zone.today.year).and(Animation.where.not(syobocal_tid: nil)).limit(6)

    @tier_lists = TierList.order(id: :DESC).limit(4)

    @tier_list_new = TierList.new
  end
end
