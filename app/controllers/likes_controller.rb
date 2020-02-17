class LikesController < ApplicationController
  	before_action :authenticate_user!
	before_action :load_comment
	before_action :find_like, only: [:destroy]
	def create
		if already_liked?
			flash[:notice] = "You can't like more than once"
			redirect_to @comment.project
		else
			@like = @comment.likes.create(user_id: current_user.id)
		end
	end

	def destroy
		if !(already_liked?)
		    flash[:notice] = "Cannot unlike"
		else
		    @like.destroy
		end
	end

	private
		def load_comment
			@comment = Comment.find(params[:comment_id])
		end

		def find_like
		   @like = @comment.likes.find(params[:id])
		end

		def already_liked?
			Like.where(comment_id: @comment.id, user_id: current_user.id).exists?
		end
end
