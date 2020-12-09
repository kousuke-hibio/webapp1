class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def index
    @posts = Post.includes(:images).order('created_at DESC')
  end 

  def show 
    @post = Post.includes(:images).find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    @favorite = Favorite.new 
  end 

  def create
    
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = '投稿に成功しました。'
      redirect_to @post
    else
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'new'
    end 
  end

  def new 
    @post = Post.new
    @post.images.new
  end 

  def update
    if @post.update(post_params)
      flash[:success] = '更新に成功しました。'
      redirect_to @post
    else
      render :edit
      flash.now[:danger] = '更新に失敗しました。'
    end 
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, images_attributes: [:url]
    ).merge(user_id: current_user.id)
  end 

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end 
  end 
end
