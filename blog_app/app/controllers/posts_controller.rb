class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  def home
    @top_posts = Post.all.limit(3).order(created_at: :desc)
  end

  def new
    @posts = Post.new
  end

  def create
    new_post = params[:post].permit(:title, :author, :description, :created_at)
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

    redirect_to posts_path
  end

  def show
    id = params[:id]
    @post = Post.find(id)
  end

  def edit
    id = params[:id]
    @post = Post.find(id)
    if @post.tags.length > 0
      @tags = @post.tags
      @update_tags = ""
      @tags.each do |tag|
        @update_tags += " #{tag.name}"
      end
    else
      @update_tags = ""
    end
  end

  def update
    new_update_post = params[:post].permit(:title, :author, :description)
    new_update_tag = params[:tag].permit(:name)

    break_tags_on_white_space = []
    
    break_tags_on_white_space = new_update_tag["name"].split(" ")

    post = Post.find_by_id(params[:id])

    post.update_attributes(new_update_post)

    check_ids_for_empty = post.tags.pluck(:id)
    post.tags.destroy_all
    
    check_ids_for_empty.each do |check_id|
      Tag.find_by_id(check_id).destroy
    end

      break_tags_on_white_space.each do |tag|
        downcase_single_tag = tag.downcase!

        existing_tag = Tag.where(name: tag).first
        if !existing_tag
          new_tag = Tag.create(name: tag)
          post.tags << new_tag
        else
          post.tags.each do |post|
            if post != existing_tag
              post.tags << existing_tag
            end
          end
        end
      end
    redirect_to posts_path(params[:id])
  end

  def destroy
    delete_post = Post.find_by_id(params[:id])
    
    delete_post.blogs.each do |association|
      if association.post_id == delete_post.id
        tag = association.tag_id
        suspect_tag = Tag.all.find(tag)
        association.destroy
        if suspect_tag.blogs.length == 0
          suspect_tag.destroy
        end

      end
    end
    delete_post.destroy
    redirect_to posts_path
  end

end
