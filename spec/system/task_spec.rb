require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_session_path
      sleep(1)
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'Log in'
      sleep(1)
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される(新規登録が正常に完了する)' do
        visit new_task_path
        sleep(1)
        fill_in 'task_name', with: 'パパ'
        fill_in 'task_content', with: '日曜日歯医者'
        fill_in 'task_timelimit', with: '002023-12-17'
        find("#task_status").find("option[value='完了']").select_option
        click_on '登録する'
        sleep(1)
        expect(page).to have_content '完了'

      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, content: '自転車修理', user: user)
        FactoryBot.create(:task, content: '買い物', user: user)
        FactoryBot.create(:task, content: '洗濯', user: user)
        visit tasks_path
        sleep(1)
        task_list = all('.task_list')[0] 
        expect(task_list).to have_content '洗濯'        
      end
    end
    context 'タスクが終了期限の降順に並び替えられた場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, timelimit: '002024-01-10', user: user)
        FactoryBot.create(:task, user: user)
        FactoryBot.create(:task, timelimit: '002023-12-15', user: user)
        visit tasks_path
        sleep(1)
        click_on '終了期限でソートする'
        sleep(1)
        task_list = all('.task_list')[0]
        expect(task_list).to have_content '2023-11-01'  
      end
    end  
    context 'タスクが優先順位の高い順に並び替えられた場合' do
      it '優先順位「高」のタスクが一番上に表示される' do
        FactoryBot.create(:task, rank: '低', user: user)
        FactoryBot.create(:task, user: user )
        FactoryBot.create(:task, rank: '高', user: user)
        visit tasks_path
        sleep(1)
        click_on '優先順位でソートする'
        sleep(1)
        task_list = all('.task_list')[0]
        expect(task_list).to have_content '高'  
      end
    end  
  end

  describe '一覧表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_session_path
      sleep(1)
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'Log in'
      sleep(1)
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:task, name: 'task', user: user)
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_session_path
      sleep(1)
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'Log in'
      sleep(1)
    end
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        FactoryBot.create(:task, name: '家事', user: user)
        visit task_path(Task.last)
        expect(page).to have_content '家事'
       end
     end
  end
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      FactoryBot.create(:task, name: "おじいちゃん", user: user)
      FactoryBot.create(:task, content: "掃除機" ,status: "未着手", user: user)
      FactoryBot.create(:task, content: "お歳暮準備" ,status: "完了", user: user)
      visit new_session_path
      sleep(1)
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'Log in'
      sleep(1)
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        sleep(1)
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'task_name', with: 'おじいちゃん'
        # 検索ボタンを押す
        click_on '検索'
        sleep(1)
        expect(page).to have_content 'おじいちゃん'
        expect(page).not_to have_content 'パパ'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        find("#task_status").find("option[value='未着手']").select_option
        click_on '検索'
        sleep(1)
        expect(page).to have_content '未着手'
        expect(page).not_to have_content 'お歳暮準備'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        sleep(1)
        fill_in 'task_name', with: 'パパ'
        find("#task_status").find("option[value='未着手']").select_option
        expect(page).to have_content '未着手'
        expect(page).to have_content 'パパ'
      end
    end
  end
end
