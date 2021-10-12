require 'rails_helper'

RSpec.describe Job, type: :model do
  before do
    @job = FactoryBot.build(:job)
  end

  describe '仕事の保存' do
    context '仕事の投稿ができる場合' do
      it 'すべての情報が入力されていれば投稿できる' do
        expect(@job).to be_valid
      end
      it '納品場所の情報がなくても投稿できる' do
        @job.place = ''
        expect(@job).to be_valid
      end
      it '備考の情報がなくても投稿できる' do
        @job.memo = ''
        expect(@job).to be_valid
      end
    end

    context '仕事の情報がが投稿できない場合' do
      it '仕事概要が空だと登録できない' do
        @job.name = ''
        @job.valid?
        expect(@job.errors.full_messages).to include("仕事概要を入力してください")
      end
      it 'カテゴリーのIDが空だと登録でききない' do
        @job.category_id = ''
        @job.valid?
        expect(@job.errors.full_messages).to include("加工の種類を選択してください")
      end   
      it 'カテゴリーのIDが1(選択されていない状態)だと登録でききない' do
        @job.category_id = '1'
        @job.valid?
        expect(@job.errors.full_messages).to include("加工の種類を選択してください")
      end
      it '連絡先が空だと登録でききない' do
        @job.contact = ''
        @job.valid?
        expect(@job.errors.full_messages).to include("連絡先を入力してください")
      end
    end
  end
end