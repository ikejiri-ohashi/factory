require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの保存' do

    context 'コメントの投稿ができる場合' do
      it 'テキストが入力されていれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context '仕事の情報がが投稿できない場合' do
      it '仕事概要が空だと登録できない' do
        @comment.content = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end

    end
  end
end