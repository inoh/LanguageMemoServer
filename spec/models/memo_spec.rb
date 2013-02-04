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

    it "タグが新規登録できること" do
      lambda { 
        Memo.create!(title: "dog", note: "犬",
                     tag_relations_attributes: {tag_1: { tag_id: tags(:english).id} })
      }.should change(TagRelation, :count).by(1)
    end

    it "タグが追加登録できること" do
      lambda { 
        @memo.update_attributes!(tag_relations_attributes: { 
                                 tag_1: { id: @memo.tag_relations.first.id, tag_id: tags(:english).id},
                                 tag_2: { id: nil, tag_id: tags(:other).id} })
      }.should change(TagRelation, :count).by(1)
    end

    it "タグが削除されること" do
      lambda { 
        @memo.update_attributes!(tag_relations_attributes: { 
                                 tag_1: { id: @memo.tag_relations.first.id, tag_id: tags(:english).id, _destroy: "1"},
                                 tag_2: { id: nil, tag_id: tags(:other).id} })
      }.should change(TagRelation, :count).by(0)
    end

  end

end
