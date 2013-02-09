# -*- coding: utf-8 -*-
require 'spec_helper'

describe Tag do
  fixtures :tags, :memos, :tag_relations

  describe "未入力の確認" do

    before(:all) do
      @tag = Tag.new
    end

    it "バリデーションが失敗すること" do
      @tag.should_not be_valid
    end

    it "名称が入力されていること" do
      @tag.should have(1).errors_on(:name)
    end

  end

  describe "タグの単純更新" do

    it "新規登録" do
      lambda {
        Tag.create!(name: "テスト")
      }.should change(Tag, :count).by(1)
    end

    it "メモ更新" do
      tag = Tag.find(tags(:english).id)
      tag.update_attributes(name: "更新後")
      Tag.find(tag.id).name.should == "更新後"
    end

  end

  describe "メモの一覧を取得する" do

    before(:each) do
      @tag = Tag.create!(name: "test")
    end

    it "memosがあるかどうか" do
      Tag.instance_methods.include?(:memos).should == true
    end

    it "関連が無い場合" do
      Tag.find(@tag.id).memos.count == 0
    end

    it "関連がある場合" do
      tags(:english).memos.count == 1
    end

  end

end
