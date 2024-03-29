class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    # @posts = current_user.posts
    @posts = Post.all
  end

  def show
    @favorite  =current_user.favorites.find_by(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if params[:back]
      render :new
    elsif @post.save
      UserMailer.user_mailer(current_user).deliver
      redirect_to posts_path, notice: "Post was successfully created." 
    else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
  

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def confirm 
    @post =Post.new(post_params)
    @post.user_id = current_user.id
    render :new if @post.invalid?
  end


  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :image_cache)
  end
end
