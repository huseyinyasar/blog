class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new # view'da bir post nesnesi arayacak kod varsa eli boş kalmasın diye
  end

  def create
    # @post = Post.new(post_params)
    # Bu yanlis, guvenlik nedeniyle attrlere izin vermemiz lazim
    @post = Post.new(params[:post].permit(:title, :body))

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:title, :body))  # istersen sadece belli attr'leri update yapabilirsin
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

end
