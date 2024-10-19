class ReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    # Busca el usuario anónimo si no hay un usuario autenticado
    if current_user.nil?
      # El usuario no está autenticado (current_user es nil)
      anonymous_user = User.find_by(email: 'anonimo@anonimo.com')
    end
    
    # Usa el usuario actual si está autenticado o el usuario anónimo si no está autenticado
    user = current_user || anonymous_user

    # Log para verificar el usuario asignado (autenticado o anónimo)
    #Rails.logger.info "Usuario asignado: #{user.inspect}"

    # Crear nueva reacción asociada al usuario (autenticado o anónimo)
    #@reaction = @post.reactions.new(user: user, like: reaction_params[:like])

    # Crear o actualizar la reacción asociada al usuario (autenticado o anónimo)
    @reaction = @post.reactions.find_or_initialize_by(user: user)
    @reaction.like = reaction_params[:like]

    if @reaction.save
      respond_to do |format|
        format.turbo_stream # Responder con Turbo Stream
        format.html { redirect_to @post, notice: 'Reacción registrada exitosamente.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: 'Error al registrar la reacción.' }
      end
    end
  end

  private

  def reaction_params
    params.require(:reaction).permit(:like)
  end
end
