# -*- coding: utf-8 -*-
require 'spec_helper'

describe Memo do
  fixtures :memos, :tags, :tag_relations

  describe "未入力の確認" do

    before(:all) do
      @memo = Memo.new
    end

    it "バリデーションが失敗すること" do
      @memo.should_not be_valid
    end

    it "タイトルが入力されていること" do
      @memo.should have(1).errors_on(:title)
    end

    it "内容が入力されていること" do
      @memo.should have(1).errors_on(:note)
    end

  end

  describe "メモの単純更新" do

    it "新規登録" do
      lambda {
        Memo.create!(title: "dog", note: "犬")
      }.should change(Memo, :count).by(1)
    end

  end

  describe "タグの同時登録" do

    before(:each) do
      @memo = memos(:english)
    end

    it "バリデーションが成功すること" do
      @memo.should be_valid
    end

    it "タグが登録されていること" do
      @memo.should have_at_least(1).tags
    end

    it "タグが追加登録できること"

  end

end
