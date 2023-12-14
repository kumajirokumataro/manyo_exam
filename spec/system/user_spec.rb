require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー登録機能' do
    context 'ユーザー新規登録した場合' do
      it '新規登録が正常に完了する' do
        visit new_user_path
        sleep(1)
        fill_in 'user_name', with: 'kumiko'
        fill_in 'user_email', with: 'kumiko@gmail'
        fill_in 'user_password', with: 'ninniku'
        fill_in 'user_password_confirmation', with: 'ninniku'
        click_on 'Create my account'
        sleep(1)
        expect(page).to have_content 'kumikoのページ'
        expect(page).to have_content 'kumiko@gmail'
      end
    end
    context 'ログインせずにタスク一覧にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        sleep(1)
        expect(page).to have_content 'Log in'        
      end
    end
  end
  describe 'セッション機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:other_user) { FactoryBot.create(:admin_user) }
    let!(:other_task) { FactoryBot.create(:second_task, user: other_user) }
    before do
      visit new_session_path
      sleep(1)
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'Log in'
      sleep(1)
    end
    context 'ログインした場合' do
      it "正常にログインする" do
        expect(page).to have_content "#{user.name}のページ"
        expect(page).to have_content "#{user.email}" 
      end
    end
    context 'ログインした場合' do
      it "自分の詳細ページに飛べること" do
        visit tasks_path
        sleep(1)
        click_on 'プロフィール'
        sleep(1)
        expect(page).to have_content "#{user.name}のページ"
        expect(page).to have_content "#{user.email}"         
      end
    end
    context '他人の詳細画面に飛んだ場合' do
      it "自分のタスク一覧画面に遷移すること" do
        visit user_path(other_user.id)
        sleep(1)
        expect(page).to have_content 'パパ'
        expect(page).to have_content '日曜日歯医者'
      end
    end
    context 'ログアウトした場合' do
      it "正常にログアウトが完了する" do
        click_on 'ログアウト'
        sleep(1)
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe '管理画面' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:task) { FactoryBot.create(:task, user: user) }
      let!(:other_user) { FactoryBot.create(:admin_user) }
      let!(:other_task) { FactoryBot.create(:second_task, user: other_user) }
    before do
      visit new_session_path
      sleep(1)
      fill_in 'session_email', with: other_user.email
      fill_in 'session_password', with: other_user.password
      click_on 'Log in'
      sleep(1)
    end
      context '管理ユーザーが管理画面にアクセスした場合' do
      it "管理画面にアクセスできること" do
        visit admin_users_path
        sleep(1)
        expect(page).to have_content user.name
        expect(page).to have_content other_user.name
      end
    end
      context '一般ユーザーが管理画面にアクセスした場合' do
      it "管理画面にアクセスできないこと" do
        click_on 'ログアウト'
        sleep(1)
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_on 'Log in'
        sleep(1)
        visit admin_users_path
        sleep(1)
        expect(page).to have_content '終了期限でソートする'
        expect(page).to have_content '優先順位でソートする'
      end
    end
    context '管理ユーザーがユーザーの新規登録をした場合' do
      it "正常に新規登録ができること" do
        visit new_user_path
        sleep(1)
        fill_in 'user_name', with: 'kumiko'
        fill_in 'user_email', with: 'kumiko@gmail.com'
        fill_in 'user_password', with: 'ninniku'
        fill_in 'user_password_confirmation', with: 'ninniku'
        click_on 'Create my account'
        sleep(1)
        expect(page).to have_content 'kumikoのページ'
        expect(page).to have_content 'kumiko@gmail.com'
      end
    end
        
    context '管理ユーザーがユーザー詳細画面にアクセスした場合' do
      it "詳細画面にアクセスできること" do
        visit user_path(user.id)
        sleep(1)
        expect(page).to have_content "#{user.name}のページ"
        expect(page).to have_content "#{user.email}" 
      end
    end
    context '管理ユーザーが編集画面からユーザーを編集した場合' do
      it "編集できること" do
        visit edit_admin_user_path(user.id)
        sleep(1)
        fill_in 'user_name', with: 'yuko'
        fill_in 'user_email', with: 'yuko@gmail'
        find("#user_admin").find("option[value='true']").select_option
        fill_in 'user_password', with: 'coffee'
        fill_in 'user_password_confirmation', with: 'coffee'
        click_on 'Create account'
        sleep(1)
        expect(page).to have_content 'yuko@gmail'
      end
    end
    context '管理ユーザーがユーザーを削除した場合' do
      it "正常に削除できること" do
        visit admin_users_path
        sleep(1)
        all('.btn.btn-warning')[0].click
        sleep(2)
        page.driver.browser.switch_to.alert.accept
        sleep(1)
        expect(page).not_to have_content user.name
        expect(page).not_to have_content user.email
      end
    end
  end
end