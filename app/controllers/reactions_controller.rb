class ReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @reaction = @post.reactions.new(user: current_user, like: params[:like])
    if @reaction.save
      redirect_to @post, notice: 'Reacción registrada exitosamente.'
    else
      redirect_to @post, alert: 'Error al registrar la reacción.'
    end
  end
 end