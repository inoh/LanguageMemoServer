# -*- coding: utf-8 -*-
class Tag < ActiveRecord::Base
  has_many :tag_relations
  
  attr_accessible :name

  validates :name, :presence => true
  
  def new_relation(params)
    TagRelation.new(params) do |tag_relation|
      tag_relation.tag_id = id
    end
  end
  
  def memos
    #tag_relations.inject([]){|ret, tag_relation| ret << tag_relation.memo }.compact
    tag_relations.map{|tag_relation| tag_relation.memo}.cmpact
  end
end
