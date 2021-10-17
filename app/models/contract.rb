class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :contracter, class_name: 'User'
  belongs_to :job

  validates :user_id, presence: true
  validates :job_id, presence: true
  validates :contracter_id, presence: true
end
