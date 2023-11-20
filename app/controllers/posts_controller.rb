class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = if signed_in?
               {
                 "DraftPosts" => Post.draft,
                 "PublishedPosts" => Post.published,
                 "ScheduledPosts" => Post.scheduled
               }
             else
               {
                 "PublishedPosts" => Post.published
               }
             end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    params = params_sanitised

    published_at = parse_published_at params
    post_type = Post::get_type published_at

    @post = post_type.constantize.new params
    if @post.save
      redirect_to post_path @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    params = params_sanitised

    published_at = parse_published_at params
    new_post_type = Post::get_type published_at

    if @post.type != new_post_type
      @post = @post.becomes! new_post_type.constantize
    end

    if @post.update params
      redirect_to post_path @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def params_sanitised
    params.require(:post).permit(:title, :content, :published_at)
  end

  def parse_published_at(params)
    DateTime.new *(1..5).to_a.map { |index| params["published_at(#{index}i)"].to_i } rescue nil
  end

  def set_blog_post
    @post = signed_in? ? Post.find(params[:id]) : Post.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path
  end
end
