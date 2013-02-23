# -*- coding: utf-8 -*-

require 'spec_helper'

describe Account do

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
      @account.authenticate.should == false
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
      @account.authenticate.should == true
    end
  end
end
