class CommentsController < ApplicationController

  def index
    find_child_method
    @comments = @post.comments
  end
 
  def new
    find_child_method
    @comment = @post.comments.new
  end

  def create
    find_child_method
    
    new_comment = params.require(:comment).permit(:name, :body)
    @comment = @post.comments.create(new_comment)

    redirect_to [@post, @comment]
  end

  def show
    find_child_method
    @comment = @post.comments.find(params[:id])
  end

  private

  def find_child_method
    post_id = params[:post_id]
    @post = Post.find(post_id)
  end
end
