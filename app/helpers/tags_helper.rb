module TagsHelper
  def tag_collection
    Tag.all.inject([]){|r,v| r << [v.name, v.id]}
  end
end
