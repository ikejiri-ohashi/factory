class Request < ApplicationRecord
  belongs_to :user
  belongs_to :request, class_name: 'User'
  belongs_to :job

  validates :user_id, presence: true
  validates :job_id, presence: true
  validates :request_id, presence: true
end
