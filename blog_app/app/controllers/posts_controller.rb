class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :asc)
  end
  def home
    @top_posts = Post.all.limit(3).order(created_at: :asc)
  end

  def new
  end

  def create
    new_post = params[:post].permit(:title, :author, :description)
    new_tag = params[:tag].permit(:name)
    link_post = Post.create(new_post)

    break_tags_on_white_space = []
    
    break_tags_on_white_space = new_tag["name"].split(" ")

    break_tags_on_white_space.each do |single_tag|
      downcase_single_tag = single_tag.downcase!
      downcase_single_tag = Tag.where(name: single_tag).first_or_create
      if downcase_single_tag.created_at != Time.now
        link_post.tags << downcase_single_tag
      end
    end

    redirect_to "/posts"
  end

  def show
    id = params[:id]
    @post = Post.find(id)
  end

  def edit
    id = params[:id]
    @post = Post.find(id)
  end

  def update
    edit_post = params[:post].permit(:title, :author, :description)
    update_post = Post.find_by_id(params[:id])
    update_post.update_attributes(edit_post)
    update_post.save

    redirect_to "/posts/#{params[:id]}"
  end

  def destroy
    delete_post = Post.find_by_id(params[:id])
    delete_post.destroy

    redirect_to "/posts"
  end

end
