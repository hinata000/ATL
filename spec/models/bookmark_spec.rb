require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:bookmark) { build(:bookmark) }

  context 'user_idとanimation_idが入力された場合' do
    example '登録できること' do
      expect(bookmark).to be_valid
    end
  end

  context 'user_idが入力されていない場合' do
    before { bookmark.user_id = '' }

    example '登録できないこと' do
      expect(bookmark).to be_invalid
    end
  end

  context 'animation_idが入力されていない場合' do
    before { bookmark.animation_id = '' }

    example '登録できないこと' do
      expect(bookmark).to be_invalid
    end
  end
end
