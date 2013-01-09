# -*- coding: utf-8 -*-
require 'spec_helper'

describe Tag do
  fixtures :tags

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

end
