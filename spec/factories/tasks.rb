FactoryBot.define do
  factory :task do
    name { 'パパ' }
    content { '日曜日歯医者' }
    timelimit {'002023-11-01'}
    status {'未着手'}
    rank {'中'}
    #label {'その他'}
    #after(:build) do |task|
      #label = create(:label)
      #task.connections << build(:connection, task: task, label: label)
    #end
  end
  factory :second_task, class: Task do
    name { 'ママ' }
    content { 'イオン' }
    timelimit {'002023-12-01'}
    status {'完了'}
    rank {'中'}
    #label {'育児関連'}
    #after(:build) do |task|
      #label = create(:label)
      #task.connections << build(:connection, task: task, label: label)
    #end
  end
end