# -*- coding: utf-8 -*-
class TagRelation < ActiveRecord::Base
  belongs_to :memo
  belongs_to :tag

  attr_accessible :tag_id, :memo_id, :_delete
  
  validate :tag_id, :uniqueness => true, :scope => :memo_id
end
