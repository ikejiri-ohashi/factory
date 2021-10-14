FactoryBot.define do
  factory :company_profile do
    category_id                 { '2' }
    sub_category_id             { '2' }
    content                     { 'レーザー加工が得意です' }
    self_introduction           { '創業〇〇年の企業です' }
    sub_category_id             { '2' }
    company_url                 { 'www.example.com' }
    contact                     { 'example@gmail.com' }
    association :user
  end
end
