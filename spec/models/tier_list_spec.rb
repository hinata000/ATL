require 'rails_helper'

RSpec.describe TierList, type: :model do
  let(:tier_list) { create(:tier_list) }

  context 'user_idがない場合' do
    before { tier_list.user_id = nil }

    example '作成できないこと' do
      expect(tier_list).to be_invalid
    end
  end

  context 'animation_idがない場合' do
    before { tier_list.user_id = nil }

    example '作成できないこと' do
      expect(tier_list).to be_invalid
    end
  end

  context 'スコア、spoilerが入力された場合' do
    example '作成できること' do
      expect(tier_list).to be_valid
    end
  end

  context 'スコアが入力されていない場合' do
    before { tier_list.tier_score = nil }

    example '作成できないこと' do
      expect(tier_list).to be_invalid
    end
  end

  context 'スコアが1から5以外の数値である場合' do
    before { tier_list.tier_score = 0 }

    example '作成できないこと' do
      expect(tier_list).to be_invalid
    end
  end

  context 'レビューが501文字以上である場合' do
    before { tier_list.comment = 'a' * 501 }

    example '作成できないこと' do
      expect(tier_list).to be_invalid
    end
  end
end
