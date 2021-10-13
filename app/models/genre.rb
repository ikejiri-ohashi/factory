class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '個人' },
    { id: 3, name: '企業' }
  ]
  include ActiveHash::Associations
  belongs_to :users
end
