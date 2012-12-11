class TagRelationsController < ApplicationController
  before_filter :find_tag
  
  def create
    @tag_relation = @tag.new_relation(params[:tag_relation])

    respond_to do |format|
      if @tag_relation.save
        format.html { redirect_to tag_url(@tag), notice: 'TagRelation was successfully created.' }
        format.json { render json: @tag_relation, status: :created }
      else
        format.html { render tag_url(@tag) }
        format.json { render json: @tag_relation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def find_tag
      @tag = Tag.find(params[:tag_id])
    end
end
