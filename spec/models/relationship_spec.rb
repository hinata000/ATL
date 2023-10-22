require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { FactoryBot.create(:relationship) }

  context 'follower_idとfollowed_idが入力された場合' do
    example '登録できること' do
      expect(relationship).to be_valid
    end
  end

  context 'follower_idが入力されていない場合' do
    before { relationship.follower_id = '' }

    example '登録できないこと' do
      expect(relationship).to be_invalid
    end
  end

  context 'followed_idが入力されていない場合' do
    before { relationship.followed_id = '' }

    example '登録できないこと' do
      expect(relationship).to be_invalid
    end
  end
end
