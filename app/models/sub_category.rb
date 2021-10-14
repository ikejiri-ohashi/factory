class SubCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '切削加工全般' },
    { id: 3, name: '旋盤加工' },
    { id: 4, name: 'マシニング加工' },
    { id: 5, name: '研削' },
    { id: 6, name: '研磨' },
    { id: 7, name: 'タッピング' },
    { id: 8, name: '塑性加工全般' },
    { id: 9, name: 'プレス(~200t)' },
    { id: 10, name: 'プレス(200t~)' },
    { id: 11, name: '鍛造' },
    { id: 12, name: '板金加工全般' },
    { id: 13, name: 'シャーリング' },
    { id: 14, name: 'ベンダー' },
    { id: 15, name: 'レーザー' }
  ]
  include ActiveHash::Associations
  belongs_to :jobs
end
