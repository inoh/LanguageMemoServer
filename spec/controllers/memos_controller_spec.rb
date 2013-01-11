# -*- coding: utf-8 -*-
require 'spec_helper'

describe MemosController do
  fixtures :memos

  it "MemosControllerを使っていること" do
    controller.should be_an_instance_of(MemosController)
  end

  describe "メモの一覧を取得" do

    before do
      get 'index'
    end

    it "リクエストが成功すること" do
      response.should be_success
    end

    it "メモを全件ロードしていること" do
      assigns[:memos].should == [memos(:english)]
    end

    it "memos/indexを描画すること" do
      response.should render_template("memos")
    end

  end

  describe "指定したメモの取得" do

    before do
      get 'show', :id => memos(:english).id
    end

    it "リクエストが成功すること" do
      response.should be_success
    end

    it ":idで取得したメモをロードしていること" do
      assigns[:memo].should == memos(:english)
    end

    it "memos/showを描画すること" do
      response.should render_template("memos/show")
    end

  end

  describe "メモの新規登録" do

    describe "メモの新規画面取得" do

      before do
        get 'new'
      end

      it "リクエストが成功すること" do
        response.should be_success
      end

      it "空のメモが作成されていること" do
        pending("オブジェクトの中身の比較方法がわからない") do
          assigns[:memo].should == Memo.new
        end
      end

      it "memos/newを描画すること" do
        response.should render_template("memos/new")
      end

    end

    describe "メモが新規登録できること" do

      before do
        post 'create', {title: "dog", note: "犬"}
      end

      it "リクエストが成功すること" do
        response.should be_success
      end

    end

  end

end
