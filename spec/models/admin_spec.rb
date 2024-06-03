# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
  before(:all) do
    Rails.application.load_seed
  end

  it "有効なユーザーの場合は保存されるか" do
    expect(FactoryBot.build(:admin)).to be_valid
  end

end