FactoryBot.define do
  factory :user do
    name { "kumiko" }
    email { "kumiko@gmail" }
    password { "78910" }
    admin { false }
  end
  factory :admin_user, class: User do
    name { "satomi" }
    email { "satomi@gmail" }
    password { "123456" }
    admin { true }
  end
end
