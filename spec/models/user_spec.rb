require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user.name = ''
      user.valid?
      expect(user.errors.full_messages).to include("Nameを入力してください")
    end
    it 'emailが空では登録できない' do
      user.email = ''
      user.valid?
      expect(user.errors.full_messages).to include "メールアドレスを入力してください"
    end
  end
end