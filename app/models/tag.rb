class Tag < ActiveRecord::Base
  has_many :tag_relations
  
  attr_accessible :name
  
  def new_relation(params)
    TagRelation.new(params) do |tag_relation|
      tag_relation.tag_id = id
    end
  end
  
  def memos
    tag_relations.inject([]) do |ret, tag_relation|
      ret << tag_relation.memo
    end
  end
end
