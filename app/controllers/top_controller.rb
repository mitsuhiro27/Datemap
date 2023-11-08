class TopController < ApplicationController
  def index
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
  end
end
