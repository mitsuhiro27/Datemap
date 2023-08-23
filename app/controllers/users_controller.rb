class UsersController < ApplicationController
  def show
    @users = User.find_by(id: params[:id])
  end

  def index
    @users = User.all
  end
end
