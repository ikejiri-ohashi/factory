class Category < ActiveHash::Base
  self.data = [
    {id: 1, name: '選択してください'},
    {id: 2, name: '切削加工'},
    {id: 3, name: '塑性加工'},
    {id: 4, name: '板金加工'},
  ]
  include ActiveHash::Associations
  belongs_to :jobs
end