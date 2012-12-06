class Document < ActiveRecord::Base
  DOCUMENT_DIRECTORY = File.join(Rails.root, "files")
  
  belongs_to :memo
  
  attr_accessor :upload_data
  attr_accessible :memo_id, :upload_data
  
  before_save :save_upload_data
  
  def full_path
    File.join(DOCUMENT_DIRECTORY, self.path)
  end
  
  private
    def save_upload_data
      Dir.mkdir DOCUMENT_DIRECTORY unless Dir.exist? DOCUMENT_DIRECTORY
      File.open(original_filename, "wb"){|f| f.write self.upload_data.read}
      self.path = self.upload_data.original_filename
    end
    
    def original_filename
      File.join(DOCUMENT_DIRECTORY, self.upload_data.original_filename)
    end
end
