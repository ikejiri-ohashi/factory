FactoryBot.define do
  factory :job do
    name                  {'This is the job'}
    place                 {'愛知県'}
    deadline              {'10月12日'}
    category_id           {'2'}
    memo                  {'This is the memo'}
    contact               {'080-0000-0000'}
    association :user
  end
end