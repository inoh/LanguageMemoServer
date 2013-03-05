# -*- coding: utf-8 -*-
require 'spec_helper'

describe Account do
  fixtures :account_sessions

  describe "未入力の確認" do
    before do
      @account = Account.new
    end

    it "バリデーションが失敗すること" do
      @account.should_not be_valid
    end

    it "ユーザ名が設定されていること" do
      @account.should have(1).errors_on(:username)
    end

    it "パスワードが設定されていること" do
      @account.should have(1).errors_on(:password)
    end

    it "認証失敗" do
      @account.authenticate.should == nil
    end
  end

  describe "認証の確認" do
    before do
      @account = Account.new(username: 'inoue', password: 'inoue')
    end

    it "バリデーションが成功すること" do
      @account.should be_valid
    end

    it "認証成功" do
      @account.login.should_not == nil
    end

    it "セッション作成" do
      lambda { 
        @account.login
      }.should change(AccountSession, :count).by(1)
    end

    it "パスワード誤り" do
      account = Account.new(username: 'inoue', password: 'NG')
      account.login.should == nil
    end
  end

  describe "再ログイン" do
    before do
      @account = Account.new(username: 'inoue', password: 'inoue')
      @account.login
    end

    it "認証成功" do
      lambda { 
        account = Account.new(session_token: account_sessions(:success))
        account.authenticate.should == @account.session_token
      }.should change(AccountSession, :count).by(0)
    end

    it "認証失敗" do
      lambda { 
        account = Account.new(session_token: "error")
        account.authenticate.should == nil
      }.should change(AccountSession, :count).by(0)
    end

    it "再認証" do
      lambda { 
        account = Account.new(username: 'inoue', password: 'inoue')
        account.authenticate
        account.session_token.should == @account.session_token
      }.should change(AccountSession, :count).by(0)
    end
  end
end
