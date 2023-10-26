class Animation < ApplicationRecord
  enum season: { spring: 1, summer: 2, autumn: 3, winter: 4 }

  has_one :animation_detail
  has_many :tier_lists, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def import_from_annict
    base_url = "https://api.annict.com/v1"
    access_token = ENV["ANNICT_ACCESS_TOKEN"]

    start_year = 2020
    end_year = Time.zone.today.year
    seasons = ["spring", "summer", "autumn", "winter"]

    (start_year..end_year).each do |year|
      seasons.each.with_index(1) do |season, index|

        data = JSON.parse(Faraday.get("#{base_url}/works?fields=id&per_page=50&filter_season=#{year}-#{season}&sort_watchers_count=desc&access_token=#{access_token}").body)

        data_count = data["total_count"]
        page_count = (data_count / 50.to_f).ceil

        current_page = 1

        while current_page <= page_count do
          data = JSON.parse(Faraday.get("#{base_url}/works?fields=title,title_kana,images,twitter_username,official_site_url,media_text,syobocal_tid,season_name_text&page=#{current_page}&per_page=50&filter_season=#{year}-#{season}&sort_watchers_count=desc&access_token=#{access_token}").body)
          animations = data["works"]

          animations.each do |animation|
            Animation.find_or_initialize_by(title: animation["title"]).update(
              title_kana: animation["title_kana"],
              year: year,
              season: index,
              image: animation["images"]["facebook"]["og_image_url"],
              twitter_username: animation["twitter_username"],
              official_site_url: animation["official_site_url"],
              media_text: animation["media_text"],
              syobocal_tid: animation["syobocal_tid"],
              season_name_text: animation["season_name_text"]
            )
          end

          current_page += 1
        end
      end
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title", "title_kana", "id", "bookmarks_count", "tier_average", "year", "season", "score"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["bookmarks"]
  end

  def tier_score_change(score)
    if score >= 4.5
      "SS"
    elsif score >= 3.5
      'S'
    elsif score >= 2.5
      'A'
    elsif score >= 1.5
      'B'
    elsif score >= 1
      'C'
    end
  end

  def tier_color(score)
    if score >= 4.5
      'color: #EF4444;'
    elsif score >= 3.5
      'color: #D97706;'
    elsif score >= 2.5
      'color: #F59E0B;'
    elsif score >= 1.5
      'color: #FCD34D;'
    elsif score >= 1
      'color: #10B981;'
    end
  end

  def update_tier_average

    tier_average = tier_lists.average(:tier_score).to_f

    self.update(tier_average: tier_average)

  end

  def update_score

    tier_average = self.tier_average

    lowest_tier_count = tier_lists.where(tier_score: 1).count

    tier_count = tier_lists.count

    if tier_average == 0.0
      score = 0.0
    elsif lowest_tier_count == 0
      score = ((tier_average + tier_count) * 2)
    else
      score = ((tier_average + tier_count / lowest_tier_count) * 2)
    end

    self.update(score: score)

  end

end
