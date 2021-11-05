class Deadline < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '~ 11/19(金)' },
    { id: 3, name: '~ 11/26(金)' },
    { id: 4, name: '~ 12/3(金)' },
    { id: 5, name: '~ 12/10(金)' },
    { id: 6, name: '~ 12/17(金)' },
    { id: 7, name: '~ 12/24(金)' },
    { id: 8, name: '~ 12/31(金)' }
  ]
  include ActiveHash::Associations
  belongs_to :jobs
end
