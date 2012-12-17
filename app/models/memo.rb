class Memo < ActiveRecord::Base
  has_many :documents
  has_many :tag_relations, :dependent => :destroy
  
  accepts_nested_attributes_for :tag_relations
  attr_accessible :title, :note, :tag_relations_attributes
  
  after_save :delete_blank_relations
  
  validates :title, :presence => true
  validates :note, :presence => true
  
  def new_document(params)
    Document.new(params) do |document|
      document.memo_id = id
    end
  end
  
  def tags
    tag_relations.inject([]){|r, v| r << v.tag }.compact
  end
  
  private
    def delete_blank_relations
      TagRelation.where(:memo_id => nil).each do |tag_relation|
        tag_relation.destroy
      end
    end
end
