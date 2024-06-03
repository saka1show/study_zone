# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
  before(:all) do
    Rails.application.load_seed
  end
  
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:comment)).to be_valid
  end
  
end