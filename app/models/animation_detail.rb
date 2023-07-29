class AnimationDetail < ApplicationRecord
  serialize :staffs, Array
  serialize :casts, Array

  belongs_to :animation

  # しょぼいカレンダーから情報を取得
  def import_from_syobocal
    titles = Syobocal::DB::TitleLookup.get({ "TID" => "*" })

    titles.each do |title|
      comment = title[:comment]
      parser = Syobocal::Comment::Parser.new(comment)

      # 製作陣
      staffs = parser.staffs.map do |staff|
        {
          "role": staff.instance_variable_get("@role"),
          "name": staff.instance_variable_get("@people")[0].instance_variable_get("@name")
        }
      end

      # キャスト陣
      casts = parser.casts.map do |cast|
        {
          "character": cast.instance_variable_get("@character"),
          "name": cast.instance_variable_get("@people")[0].instance_variable_get("@name")
        }
      end

      tid = title[:tid]
      animation = Animation.find_by(syobocal_tid: tid)

      # すでにレコードが存在する場合は更新、無ければ新規作成
      AnimationDetail.find_or_initialize_by(syobocal_tid: tid).update(
        animation_id: animation ? animation.id : nil,
        staffs: staffs,
        casts: casts
      )
    end
  end
end
