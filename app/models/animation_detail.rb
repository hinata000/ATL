class AnimationDetail < ApplicationRecord
  serialize :staffs, Array
  serialize :casts, Array

  belongs_to :animation

  def import_from_syobocal
    titles = Syobocal::DB::TitleLookup.get({ "TID" => "*" })

    titles.each do |title|
      comment = title[:comment]
      parser = Syobocal::Comment::Parser.new(comment)

      staffs = parser.staffs.map do |staff|
        {
          "role": staff.instance_variable_get("@role"),
          "name": staff.instance_variable_get("@people")[0].instance_variable_get("@name")
        }
      end

      casts = parser.casts.map do |cast|
        {
          "character": cast.instance_variable_get("@character"),
          "name": cast.instance_variable_get("@people")[0].instance_variable_get("@name")
        }
      end

      tid = title[:tid]
      animation = Animation.find_by(syobocal_tid: tid)

      AnimationDetail.find_or_initialize_by(syobocal_tid: tid).update(
        animation_id: animation ? animation.id : nil,
        staffs: staffs,
        casts: casts
      )
    end
  end
end
