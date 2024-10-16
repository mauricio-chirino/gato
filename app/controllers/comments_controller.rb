class CommentsController < ApplicationController
     def create
       @post = Post.find(params[:post_id])
       @comment = @post.comments.new(comment_params)
       @comment.user = current_user if user_signed_in?
       if @comment.save
         redirect_to @post, notice: 'Comentario creado exitosamente.'
       else
         redirect_to @post, alert: 'Error al crear el comentario.'
       end
     end

     private

     def comment_params
       params.require(:comment).permit(:body)
     end
   end