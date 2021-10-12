FactoryBot.define do
  factory :company_profile do
    speciality                  {'レーザー加工'}
    content                     {'レーザー加工が得意です'}
    self_introduction           {'創業〇〇年の企業です'}
    company_url                 {'www.example.com'}
    contact                     {'example@gmail.com'}
    association :user
  end
end