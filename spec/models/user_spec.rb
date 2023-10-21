require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context 'メールアドレス、ユーザー名、ユーザーID、パスワードが入力された場合' do
    example '登録できること' do
      expect(user).to be_valid
    end
  end

  context 'メールアドレスが入力されていない場合' do
    before { user.email = '' }

    example '登録できないこと' do
      expect(user).to be_invalid
    end
  end

  context 'メールアドレスが重複した場合' do

    example '登録できないこと' do
      another_user = create(:user)
      user = User.new(
        email: another_user.email,
        user_name: 'user',
        user_id: 'user2',
        password: 'password',
        password_confirmation: 'password'
      )

      user.valid?
      expect(user).to be_invalid
    end

  end

  context 'ユーザー名が入力されていない場合' do
    before { user.user_name = '' }

    example '登録できないこと' do
      expect(user).to be_invalid
    end
  end

  context 'ユーザー名が16文字以上である場合' do
    before { user.user_name = 'a' * 16 }

    example '登録できないこと' do
      expect(user).to be_invalid
    end
  end

  context 'ユーザーIDが入力されていない場合' do
    before { user.user_id = '' }

    example '登録できないこと' do
      expect(user).to be_invalid
    end
  end

  context 'ユーザーIDが16文字以上である場合' do
    before { user.user_id = 'a' * 16 }

    example '登録できないこと' do
      expect(user).to be_invalid
    end
  end

  context 'ユーザーIDが重複した場合' do

    example '登録できないこと' do
      another_user = create(:user)
      user = User.new(
        email: 'another_user@example.com',
        user_name: 'user',
        user_id: another_user.user_id,
        password: 'password',
        password_confirmation: 'password'
      )

      user.valid?
      expect(user).to be_invalid
    end

  end

  context 'パスワードが入力されていない場合' do
    before { user.password = '' }

    example '登録できないこと' do
      expect(user).to be_invalid
    end
  end

  context 'パスワードが6文字未満である場合' do
    before { user.password = 'a' * 5 }

    example '登録できないこと' do
      expect(user).to be_invalid
    end
  end

  context 'プロフィールが151文字以上である場合' do
    before { user.profile = 'a' * 151 }

    example '登録できないこと' do
      expect(user).to be_invalid
    end
  end

  describe TierList, type: :model do
    let(:tier_list) { create(:tier_list) }
    it 'ユーザーが削除された場合、所有していたTierListも削除されること' do
      user = tier_list.user
      expect {
        user.destroy
      }.to change(TierList, :count).by (-1)
    end
  end

end
