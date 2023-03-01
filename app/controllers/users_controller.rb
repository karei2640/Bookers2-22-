class UsersController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update]
    before_action :set_user, only: [:followings, :followers]
  def show
    @user = User.find(params[:id])
    Book.where(user_id: @user.id).all 
    @books = @user.books.all
    @set_relationship = current_user.relationships.new
  end
  
  def create
    @book = Book.new(book_params)
    if @user.save
     redirect_to "/users/#{@user.id}"
    else
      render 'users/edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def index
    @user = current_user
    @users = User.all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:notice] = "You have updated user successfully."
    else
      render 'users/edit'
    end
  end
  
  def destroy
    @user.delete(:user_id)
    @current_user = nil
    flash[:notice] = "Signed out successfully."
    redirect_to :root
  end
  
  def followings
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end

