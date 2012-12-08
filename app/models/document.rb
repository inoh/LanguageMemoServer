class Document < ActiveRecord::Base
  DOCUMENT_DIRECTORY = File.join(Rails.root, "files")
  
  belongs_to :memo
  
  attr_accessor :upload_data
  attr_accessible :memo_id, :upload_data

  before_save :set_filename  
  after_save :save_upload_data
  
  def full_path
    File.join(DOCUMENT_DIRECTORY, self.id.to_s)
  end
  
  private
    def set_filename
      self.filename = self.upload_data.original_filename
    end
  
    def save_upload_data
      if self.upload_data
        Dir.mkdir DOCUMENT_DIRECTORY unless Dir.exist? DOCUMENT_DIRECTORY
        File.open(full_path, "wb"){|f| f.write self.upload_data.read}
      end
    end
end
