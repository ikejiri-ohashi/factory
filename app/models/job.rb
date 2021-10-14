class Job < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :sub_category
  belongs_to_active_hash :place
  belongs_to_active_hash :deadline
  has_many :favorites, dependent: :destroy

  validates :name, :place_id, :category_id, :sub_category_id, :contact, presence: true
  validates :place_id, :category_id, :sub_category_id, :deadline_id, numericality: { other_than: 1, message: 'を選択してください' }
end
