class PostsController < ApplicationController
	def new
    @post = Post.new
  end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to :action => "index"
		else
			render "new"
		end
	end

	def index
		@posts = Post.order(created_at: :desc)
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
			redirect_to request.referer
		else
			render :show
		end
	end


	def destroy
  	@post = Post.find(params[:id])
    @post.destroy
    redirect_to :action => "index"
  end

	private
  def post_params
    params.require(:post).permit(:title, :content, :post_image, :user_id)
  end
end
