class Tag < ActiveRecord::Base
  has_many :tag_relations
  
  attr_accessible :name
  
  def memos
    tag_relations.inject([]) do |ret, tag_relation|
      ret << tag_relation.memo
    end
  end
end
