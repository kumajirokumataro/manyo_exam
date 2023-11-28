require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される(新規登録が正常に完了する)' do
        visit new_task_path
        fill_in 'task_name', with: 'パパ'
        fill_in 'task_content', with: '日曜日歯医者'
        click_on '登録する'
        expect(page).to have_content '日曜日歯医者'

      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, content: '自転車修理')
        FactoryBot.create(:task, content: '買い物')
        FactoryBot.create(:task, content: '洗濯')
        visit tasks_path
        task_list = all('.task_list')[0] 
        expect(task_list).to have_content '洗濯'        
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        FactoryBot.create(:task, name: '家事')
        visit task_path(Task.last)
        expect(page).to have_content '家事'
       end
     end
  end
end
