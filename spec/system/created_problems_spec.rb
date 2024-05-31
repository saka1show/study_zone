# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  before(:all) do
    Rails.application.load_seed
  end
  
  describe 'トップ画面のテスト'
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面に「ようこそ、Study Zoneへ！」が表示されているか' do
        expect(page).to have_content 'ようこそ、Study Zoneへ！'
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
end