class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
  has_many :jobs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :company_profiles, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follows, dependent: :destroy
  has_many :followings, through: :follows, source: :follow
  has_many :reverse_of_follows, class_name: 'Follow', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_follows, source: :user

  has_many :contracts, dependent: :destroy
  has_many :orders, through: :contracts, source: :contracter
  has_many :reverse_of_contracts, class_name: 'Contract', foreign_key: 'contracter_id'
  has_many :accepters, through: :reverse_of_contracts, source: :user

  has_many :requests, dependent: :destroy
  has_many :requesting, through: :requests, source: :request
  has_many :reverse_of_requests, class_name: 'Request', foreign_key: 'request_id'
  has_many :requested, through: :reverse_of_requests, source: :user

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true

  mount_uploader :profile_image, ProfileImageUploader

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲスト'
    end
  end

  def already_favorited?(job)
    favorites.exists?(job_id: job.id)
  end

  def already_ordered?(job)
    contracts.exists?(job_id: job.id)
  end
end
