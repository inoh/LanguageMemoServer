class TagRelation < ActiveRecord::Base
  belongs_to :memo
  belongs_to :tag

  attr_accessible :tag_id, :memo_id
end
