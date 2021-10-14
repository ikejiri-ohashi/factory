FactoryBot.define do
  factory :job do
    name                  { 'This is the job' }
    place_id              { '2' }
    deadline_id           { '2' }
    category_id           { '2' }
    sub_category_id       { '2' }
    memo                  { 'This is the memo' }
    contact               { '080-0000-0000' }
    association :user
  end
end
