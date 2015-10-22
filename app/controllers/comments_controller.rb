class CommentsController < ApplicationController
	load_and_authorize_resource

  def create
  	@post = Post.find(params[:post_id])
  	@comments = @post.comments


  	@comment = @post.comments.build(comment_params)
    @comment.user = current_user if user_signed_in?
  	@comment.save

  	redirect_to @post
  end

  def like
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @like = @comment.likes.build(user: current_user)

    if @comment.liked_by? current_user
      @comment.remove_like current_user
      redirect_to @post, notice: 'Ya no te gusta'
    elsif @comment.save
      redirect_to @post, notice: 'Gracias por el me gusta'
    else
      redirect_to @post, notice: 'Ha ocurrido un error tu like no fue guardado'
    end
  end

	private

		def comment_params
			params.require(:comment).permit(:content)
		end
end
