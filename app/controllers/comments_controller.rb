class CommentsController < ApplicationController
  def create
       @post = Post.find(params[:post_id])
       @comment = @post.comments.new(comment_params)


         # Busca al usuario anónimo por su email
        unless current_user 
          anonymous_user = User.find_by(email: "anonimo@anonimo.com")
          @comment.user = anonymous_user
        else

          @comment.user = current_user
        end  

        # Asigna el usuario autenticado o el usuario anónimo si no hay un usuario autenticado
        #@comment.user = current_user || anonymous_user


         # Verifica si se asignó correctamente un usuario
        if @comment.user.nil?
          # Si no se asignó un usuario, evitar que se guarde el comentario
          redirect_to @post, alert: 'No se pudo asignar un usuario para el comentario.' and return
        end

        Rails.logger.info "Usuario autenticado: #{current_user.inspect}"

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