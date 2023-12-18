require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  describe 'ラベル検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:label) { FactoryBot.create(:label) }
    let!(:second_label) { FactoryBot.create(:second_label) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:connection) { FactoryBot.create(:connection, task: task, label: label) }
    let!(:other_task) { FactoryBot.create(:second_task, user: user) }
    let!(:second_connection) { FactoryBot.create(:connection, task: other_task, label: second_label) }

    before do
      visit new_session_path
      sleep(1)
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'Log in'
      sleep(1)
    end
    context 'その他ラベルでタスクを検索した場合' do
      it '正しく検索される' do
        visit tasks_path
        visit tasks_path
        #//*[@id="task_id"]/option[2]
        find("#task_id").find("option[value='#{label.id}']").select_option
        all('.btn')[1].click
        sleep(1)
        expect(page).to have_content '日曜日歯医者'
        expect(page).to have_content 'パパ'
        expect(page).not_to have_content 'イオン'
      end
    end
    context 'タスクの詳細画面を開いた場合' do
      it '正しくラベル名が表示されている' do
        visit tasks_path
        sleep(1)
        visit task_path(task.id)
        expect(page).to have_content 'その他'
        expect(page).not_to have_content '育児関連'
      end
    end
  end
end