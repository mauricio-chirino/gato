class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all.includes(:user)
  end


     
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("post-details", partial: "posts/post_details", locals: { post: @post }) }
      format.html 
    end
  end
   

  def new
    @post = Post.new
  end


  def create
    @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to @post, notice: 'Post creado exitosamente.'
      else
        render :new
      end




  end



  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
  end
