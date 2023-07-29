class Animation < ApplicationRecord
  enum season: { spring: 1, summer: 2, autumn: 3, winter: 4 }
  has_one :animation_detail
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
          data = JSON.parse(Faraday.get("#{base_url}/works?fields=title,images,twitter_username,official_site_url,media_text,syobocal_tid,season_name_text&page=#{current_page}&per_page=50&filter_season=#{year}-#{season}&sort_watchers_count=desc&access_token=#{access_token}").body)
          animations = data["works"]

          animations.each do |animation|
            # すでにレコードが存在する場合は更新、無ければ新規作成
            Animation.find_or_initialize_by(title: animation["title"]).update(
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

  # def favorited?(user)
  #   favorites.where(user_id: user.id).exists?
  # end

  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end

  # def avg_score
  #   unless self.reviews.empty?
  #     reviews.average(:score).round(1).to_f
  #   else
  #     0.0
  #   end
  # end

  # def reviews_score_percentage
  #   unless self.reviews.empty?
  #     reviews.average(:score).round(1).to_f*100/5
  #   else
  #     0.0
  #   end
  # end
end
