class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    @image = @user.image
  end

  def show
    @user = User.find(params[:id])
    @image = @user.image
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def update
    @user = User.find(params[:id])
    if current_user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new 
    end 
  end

  def followings
    @user = User.find(params[:id])
    @image = @user.image
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end 

  def followers
    @user = User.find(params[:id])
    @image = @user.image
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end 

  def search 
    @user_or_post = params[:option]
    if @user_or_post == "1"
      @users = User.search(params[:search], @user_or_post)
    else
      @posts = Post.search(params[:search], @user_or_post)
    end
  end 

  def likes
    @user = User.find(params[:id])
    @image = @user.image
    @favorites = @user.favorite_posts.page(params[:page])
    counts(@user)
  end 

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end 
end
