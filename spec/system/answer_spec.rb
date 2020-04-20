require 'rails_helper'

RSpec.describe "Answers", type: :system do
  let!(:user) { create(:user) }

  let!(:taro) { create(:user, name: 'taro') }
  let!(:taro_q) { create(:question, user: taro) }

  let!(:jiro) { create(:user, name: 'jiro') }
  let!(:jiro_ans) { create(:answer, user: jiro, question: taro_q, content: 'jiroの回答') }

  let!(:saburo) { create(:user, name: 'saburo') }
  let!(:saburo_ans) { create(:answer, user: saburo, question: taro_q, content: 'saburoの回答') }

  describe 'ログインしている時' do
    subject { page }

    before do
      login_as user, scope: :user
      visit question_path(taro_q.id)
    end

    example '正常に回答できること' do
      fill_in 'answer[content]', with: ' 正しい回答'
      click_button '回答する'
      is_expected.to have_content '正しい回答'
    end

    context '異常値' do
      example 'presence: true' do
        fill_in 'answer[content]', with: ''
        click_button '回答する'
        is_expected.to have_content '回答に失敗しました'
      end

      example 'length: { maximum: 1000 }' do
        fill_in 'answer[content]', with: 'a' * 1001
        click_button '回答する'
        is_expected.to have_content '回答に失敗しました'
      end
    end
  end

  describe '削除機能が正常に働いていること' do
    # taro = 質問者
    example '回答者しか自分の回答を削除できないこと' do
      # saburoがjiroの回答を削除しようとする
      login_as saburo, scope: :user
      visit question_path(taro_q.id)
      expect(page).not_to have_selector ".delete-a-#{jiro_ans.id}"
    end

    example '回答者は自分の回答を削除できること' do
      login_as jiro, scope: :user
      visit question_path(taro_q.id)
      expect(page).to have_content 'jiroの回答'
      expect { find(".delete-a-#{jiro_ans.id}").click }.to change { taro_q.answers.count }.by(-1)
      expect(page).not_to have_content 'jiroの回答'
    end

    # 一つの回答に対して、同一人物が複数の回答を投稿している時
    # その人物が一つの回答を削除すると、残りも削除されてしまう
    example 'バグ再現テスト' do
      create(:answer, user: jiro, question: taro_q, content: 'jiroの回答2')
      login_as jiro, scope: :user
      visit question_path(taro_q.id)
      expect { find(".delete-a-#{jiro_ans.id}").click }.to change { jiro.answers.count }.from(2).to(1)
    end
  end

  describe '編集機能が正常に働いていること' do
    before do
      login_as jiro, scope: :user
      visit edit_answer_path(jiro_ans.id)
    end

    example '正常値' do
      fill_in 'answer[content]', with: '編集後の回答'
      click_on '編集内容を送信'
      expect(page).to have_content '編集後の回答'
    end

    example '異常値' do
      fill_in 'answer[content]', with: ''
      click_on '編集内容を送信'
      expect(page).to have_content '編集に失敗しました'
    end
  end
end
