class Job < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  has_many :favorites, dependent: :destroy

  validates :name, :category_id, :contact, presence: true
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
end
