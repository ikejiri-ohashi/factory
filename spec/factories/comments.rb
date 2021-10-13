FactoryBot.define do
  factory :comment do
    content { 'This is a comment for a job' }
    association :user
    association :job
  end
end
