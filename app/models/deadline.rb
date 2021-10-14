class Deadline < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '10月' },
    { id: 3, name: '11月' }
  ]
  include ActiveHash::Associations
  belongs_to :jobs
end
