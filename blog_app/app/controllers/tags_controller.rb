class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def create
    new_tag = params[:tag].permit(:name)
    Post.create(new_tag)
    redirect_to "/tags"
  end

  def show
    id = params[:id]
    @tag = Tag.find_by_id(id)
  end
end
