FactoryBot.define do
  factory :connection do
    association :task
    association :label
  end
end
