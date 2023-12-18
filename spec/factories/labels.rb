FactoryBot.define do
  factory :label do
    name { "その他" }
  end

  factory :second_label, class: Label do
    name { '育児関連' }
  end

  factory :third_label, class: Label do
    name { '家事関連' }
  end
end
