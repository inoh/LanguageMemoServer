class Memo < ActiveRecord::Base
  has_many :documents
  
  attr_accessible :note, :title
end
