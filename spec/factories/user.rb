FactoryBot.define do

  factory :user do
    login { FFaker::InternetSE.login_user_name }
    password { FFaker::Internet.password }

    trait :user do
      role { 0 }
    end

    trait :admin do
      role { 1 }
    end
  end
end
