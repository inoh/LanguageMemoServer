# -*- coding: utf-8 -*-
require 'spec_helper'

describe AccountsController do

  it "AccountsControllerを使っていること" do
    controller.should be_an_instance_of(AccountsController)
  end

  describe "ログイン画面の取得" do

    before do
      get "login"
    end

    it "リクエストが成功すること" do
      response.should be_success
    end

    it "空のアカウントが作成されていること" do
      assigns[:account].should be_instance_of(Account)
    end

    it "accounts/loginが描画されること" do
      response.should render_template("accounts/login")
    end

  end

  describe "ログイン認証成功" do

    before do
      post 'authenticate', {:account => {:username => "inoue", :password => "inoue"}}
    end

    it "セッションが開始されること" do
      session[:session_token].should_not == nil
    end

    it "リクエストが成功すること" do
      response.should redirect_to :memos
    end

  end

  describe "ログイン認証失敗" do

    before do
      post 'authenticate', {:account => {:username => "inoue", :password => "inoue2"}}
    end

    it "リクエストが成功すること" do
      response.should be_success
    end

    it "セッションが開始されること" do
      session[:session_token].should == nil
    end

    it "memos/indexを描画すること" do
      response.should render_template("accounts/login")
    end

  end

end
