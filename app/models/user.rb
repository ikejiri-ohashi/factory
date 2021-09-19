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

  validates :name, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.genre_id = 2
    end
  end

  def already_favorited?(job)
    favorites.exists?(job_id: job.id)
  end

end
