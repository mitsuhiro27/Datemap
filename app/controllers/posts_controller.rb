class PostsController < ApplicationController
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path(latest: "true")
    else
      render "new", status: :unprocessable_entity
    end
  end

  def index
    if params[:keyword].present?
      @posts = Post.where('address LIKE (?) or title LIKE(?) or content LIKE(?)', "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    elsif params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    elsif params[:most_favorited]
      @posts = Post.most_favorited
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  def show
	  @post = Post.find(params[:id])
  end

  def edit
	  @post = Post.find(params[:id])
  end
	 
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to :action => "show"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :action => "index"
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :post_image, :address, :latitude, :longitude).merge(user_id: current_user.id)
  end

  def ensure_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to new_post_path unless @post
  end
end
