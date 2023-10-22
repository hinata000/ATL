require 'rails_helper'

RSpec.xdescribe Notification, type: :model do
  let(:notification) { FactoryBot.create(:notification) }

  context 'visitor_idとvisited_idとcheckedが入力された場合' do
    example '登録できること' do
      expect(notification).to be_valid
    end
  end

  context 'visitor_idが入力されていない場合' do
    before { notification.visitor_id = '' }

    example '登録できないこと' do
      expect(notification).to be_invalid
    end
  end

  context 'visited_idが入力されていない場合' do
    before { notification.visited_id = '' }

    example '登録できないこと' do
      expect(notification).to be_invalid
    end
  end
end
