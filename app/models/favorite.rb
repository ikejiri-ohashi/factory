class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :job_id, presence: true
end
