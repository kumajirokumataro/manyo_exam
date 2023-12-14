require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', content: '失敗テスト', user: user)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', content: '', user: user)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テスト', content: '成功テスト', user: user)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user ) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.name_search('パパ')).to include(task)
        expect(Task.name_search('パパ')).not_to include(second_task)
        expect(Task.name_search('パパ').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search('未着手')).to include(task)
        expect(Task.status_search('未着手')).not_to include(second_task)
        expect(Task.status_search('未着手').count).to eq 1
        end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search('パパ','未着手')).to include(task)
        expect(Task.search('パパ','未着手')).not_to include(second_task)
        expect(Task.search('パパ','未着手').count).to eq 1
      end
    end
  end
end

#RSpec.describe Task, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
#end
