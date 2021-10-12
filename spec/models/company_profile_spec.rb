require 'rails_helper'

RSpec.describe CompanyProfile, type: :model do
  before do
    @company_profile = FactoryBot.build(:company_profile)
  end

  describe 'プロフィールの保存' do
    context 'プロフィールの保存ができる場合' do
      it '得意技術が空欄でも保存できる' do
        @company_profile.speciality = ''
        expect(@company_profile).to be_valid
      end
      it '得意技術の詳細が空欄でも保存できる' do
        @company_profile.content = ''
        expect(@company_profile).to be_valid
      end
      it '自己紹介が空欄でも保存できる' do
        @company_profile.self_introduction = ''
        expect(@company_profile).to be_valid
      end
      it 'URLが空欄でも保存できる' do
        @company_profile.company_url = ''
        expect(@company_profile).to be_valid
      end
      it '連絡先が空欄でも保存できる' do
        @company_profile.contact = ''
        expect(@company_profile).to be_valid
      end
    end
    context 'プロフィールの保存ができない場合' do
      it 'ユーザーIDガ一致していないと登録ができない' do
        
      end
    end
  end
end