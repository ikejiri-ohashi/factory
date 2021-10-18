class SubCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: '旋盤加工' },
    { id: 3, name: 'マシニング加工' },
    { id: 4, name: '研削加工' },
    { id: 5, name: '研磨加工' },
    { id: 6, name: 'その他切削加工' },
    { id: 7, name: 'プレス(~80t)' },
    { id: 8, name: 'プレス(~150t)' },
    { id: 9, name: 'プレス(~200t)' },
    { id: 10, name: 'プレス(200t以上)' },
    { id: 11, name: '鍛造' },
    { id: 12, name: 'その他塑性加工' },
    { id: 13, name: 'シャーリング' },
    { id: 14, name: 'ベンダー' },
    { id: 15, name: 'レーザー' },
    { id: 16, name: 'その他板金加工' }
  ]
  include ActiveHash::Associations
  belongs_to :jobs
end
