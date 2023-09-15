class Animation < ApplicationRecord
  enum season: { spring: 1, summer: 2, autumn: 3, winter: 4 }
  has_one :animation_detail
  has_many :tier_lists, dependent: :destroy
  has_many :tier_list_entiers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # belongs_to :user
  # has_many :favorites, dependent: :destroy
  # has_many :reviews, dependent: :destroy

  # Annictから情報を取得
  def import_from_annict
    base_url = "https://api.annict.com/v1"
    access_token = ENV["ANNICT_ACCESS_TOKEN"]

    start_year = 1970 # どの年からデータを取得したいかを指定
    end_year = Date.today.year
    seasons = ["spring", "summer", "autumn", "winter"]

    (start_year..end_year).each do |year|
      seasons.each.with_index(1) do |season, index|
        # 初回リクエストはデータの総数を調べるために実行
        data = JSON.parse(Faraday.get("#{base_url}/works?fields=id&per_page=50&filter_season=#{year}-#{season}&sort_watchers_count=desc&access_token=#{access_token}").body)

        data_count = data["total_count"]         # データの数
        page_count = (data_count / 50.to_f).ceil # ページの数

        current_page = 1

        # 現在のページ <= ページの数になるまで繰り返し処理を実行
        while current_page <= page_count do
          data = JSON.parse(Faraday.get("#{base_url}/works?fields=title,title_kana,images,twitter_username,official_site_url,media_text,syobocal_tid,released_on,season_name_text&page=#{current_page}&per_page=50&filter_season=#{year}-#{season}&sort_watchers_count=desc&access_token=#{access_token}").body)
          animations = data["works"]

          animations.each do |animation|
            # すでにレコードが存在する場合は更新、無ければ新規作成
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
    ["title", "season", "year", "bookmarks_count", "tier_average"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["bookmarks"]
  end

  def tier_score_change(score)
    if score >= 4.5
      "SS"
    elsif score >= 4
      'S'
    elsif score >= 3
      'A'
    elsif score >= 2
      'B'
    elsif score >= 1
      'C'
    end
  end

  def total_tier_score_change(score, entier_score)
    if score > 0 && entier_score > 0
      total_score = (score + entier_score) / 2
    else
      total_score = score + entier_score
    end
    if total_score >= 4.5
      "SS"
    elsif total_score >= 4
      'S'
    elsif total_score >= 3
      'A'
    elsif total_score >= 2
      'B'
    elsif total_score >= 1
      'C'
    end
  end

  def tier_color(score)
    if score >= 4.5
      'color: #EF4444;'
    elsif score >= 4
      'color: #D97706;'
    elsif score >= 3
      'color: #F59E0B;'
    elsif score >= 2
      'color: #FCD34D;'
    elsif score >= 1
      'color: #10B981;'
    end
  end

  def total_tier_color(score, entier_score)
    if score > 0 && entier_score > 0
      total_score = (score + entier_score) / 2
    else
      total_score = score + entier_score
    end
    if total_score >= 4.5
      'color: #EF4444;'
    elsif total_score >= 4
      'color: #D97706;'
    elsif total_score >= 3
      'color: #F59E0B;'
    elsif total_score >= 2
      'color: #FCD34D;'
    elsif total_score >= 1
      'color: #10B981;'
    end
  end

  def update_tier_average
    if tier_lists.average(:tier_score).to_f > 0 && tier_list_entiers.average(:tier_score).to_f > 0
      tier_average = (tier_lists.average(:tier_score).to_f + tier_list_entiers.average(:tier_score).to_f) / 2
    elsif tier_lists.average(:tier_score).to_f > 0
      tier_average = tier_lists.average(:tier_score).to_f
    elsif tier_list_entiers.average(:tier_score).to_f > 0
      tier_average = tier_list_entiers.average(:tier_score).to_f
    end
    self.update(tier_average: tier_average)
  end
end
