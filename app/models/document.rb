class Document < ActiveRecord::Base
  belongs_to :memo
  
  attr_accessor :upload_data
  attr_accessible :memo_id, :upload_data
  
  before_save :save_upload_data
  
  private
    def save_upload_data
      File.open(original_filename, "wb"){|f| f.write self.upload_data.read}
      self.path = self.upload_data.original_filename
    end
    
    def original_filename
      File.join(Rails.root, "files", self.upload_data.original_filename)
    end
end
