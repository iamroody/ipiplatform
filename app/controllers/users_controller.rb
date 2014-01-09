class UsersController < ApplicationController

  before_filter :redirect_if_unauthorized, except: [:new, :create, :show]
  before_filter :set_user, only: [:edit, :update, :show]
  before_filter :redirect_if_not_current_user, only: :show

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)


    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
  
  def index
    @users = User.all
  end

  def edit
  end

  def show
    @published_resources = Resource.where("user_id = #{session[:user_id]}").last(5)
    @upvoted_resources = Upvote.where("user_id = #{session[:user_id]}").last(5)
    #@bookmarks = Bookmark.find_all_by_user_id(session[:user_id])
    @bookmarks = Bookmark.where("user_id = #{current_user.id}").last(5)
  end

  def update
    @user.update(user_params)
    @user.save
    redirect_to users_path
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
    end

    def redirect_if_not_current_user
      redirect_to root_path, notice: 'You are not authorized to view that page.' and return unless User.find(params[:id]).eql? current_user
    end
end
