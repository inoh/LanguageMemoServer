class Memo < ActiveRecord::Base
  has_many :documents
  
  attr_accessible :note, :title
  
  def new_document(params)
    Document.new(params) do |document|
      document.memo_id = id
    end
  end
end
