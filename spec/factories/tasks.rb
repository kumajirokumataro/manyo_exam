FactoryBot.define do
  factory :task do
    name { 'パパ' }
    content { '日曜日歯医者' }
    timelimit {'002023-11-01'}
    status {'未着手'}
    rank {'中'}
  end
  factory :second_task, class: Task do
    name { 'ママ' }
    content { 'イオン' }
    timelimit {'002023-12-01'}
    status {'完了'}
    rank {'中'}
  end
end