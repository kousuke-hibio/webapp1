class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
    end 
    @posts = Post.limit(6).includes(:images).order('created_at DESC')
    @ranks = User.find(Relationship.group(:follow_id).order('count(follow_id) desc').limit(3).pluck(:follow_id))
  end
end
