class Job < ApplicationRecord
  belongs_to :user
  has_many :comments
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category

  validates :name, :place, :deadline, :category_id, :memo, :contact, presence: true
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
end
