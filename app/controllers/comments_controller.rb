class CommentsController < ApplicationController
  def create
       @post = Post.find(params[:post_id])
       @comment = @post.comments.new(comment_params)
       @comment.user = current_user || User.find_by(email: "anonimo@anonimo.com")

        if @comment.save
          respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.append("comments", partial: "comments/comment", locals: { comment: @comment }) }
            format.html { redirect_to @post, notice: 'Comentario creado exitosamente.' }
          end
        else
          respond_to do |format|
           format.turbo_stream { render turbo_stream: turbo_stream.replace("comment_errors", partial: "comments/errors", locals: { comment: @comment }) }
          format.html { redirect_to @post, alert: 'No se pudo crear el comentario.' }
          end
        end
    end

     private

     def comment_params
       params.require(:comment).permit(:body)
     end
end