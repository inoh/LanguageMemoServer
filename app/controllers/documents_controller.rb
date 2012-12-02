class DocumentsController < ApplicationController
  before_filter :find_memo
  
  # POST /memos/1/documents
  # POST /memos/1/documents.json
  def create
    @document = Document.new(params[:document]) do |document|
      document.memo_id = params[:memo_id]
    end

    respond_to do |format|
      if @document.save
        format.html { redirect_to memo_url(@memo), notice: 'Memo was successfully created.' }
        format.json { render json: @document, status: :created }
      else
        format.html { render memo_url(@memo) }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def find_memo
      @memo = Memo.find(params[:memo_id])
    end
end
