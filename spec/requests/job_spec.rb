require 'rails_helper'
describe JobsController, type: :request do
  before do
    @job = FactoryBot.create(:job)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの仕事の仕事概要が存在する' do
      get root_path
      expect(response.body).to include(@job.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの仕事の納品場所が存在する' do
      get root_path
      expect(response.body).to include(@job.place)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの仕事の希望納期が存在する' do
      get root_path
      expect(response.body).to include(@job.deadline)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの仕事の加工種別が存在する' do
      get root_path
      expect(response.body).to include(@job.category.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの仕事の投稿者の名前が存在する' do
      get root_path
      expect(response.body).to include(@job.user.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの仕事の投稿時間が存在する' do
      get root_path
      expect(response.body).to include(@job.created_at.to_s(:datetime_jp))
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get job_path(@job)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの仕事の投稿者名が存在する' do
      get job_path(@job)
      expect(response.body).to include(@job.user.name)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの仕事の投稿日時が存在する' do
      get job_path(@job)
      expect(response.body).to include(@job.created_at.to_s(:datetime_jp))
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの仕事の仕事概要が存在する' do
      get job_path(@job)
      expect(response.body).to include(@job.name)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの仕事の納品場所が存在する' do
      get job_path(@job)
      expect(response.body).to include(@job.place)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの仕事の希望納期が存在する' do
      get job_path(@job)
      expect(response.body).to include(@job.deadline)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの仕事の加工種別が存在する' do
      get job_path(@job)
      expect(response.body).to include(@job.category.name)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの仕事の備考が存在する' do
      get job_path(@job)
      expect(response.body).to include(@job.memo)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの仕事の問い合わせ先が存在する' do
      get job_path(@job)
      expect(response.body).to include(@job.contact)
    end
  end
end
