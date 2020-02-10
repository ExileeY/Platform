class CommentsController < ApplicationController
	before_action :load_entities


	def index
		load_comments
		render 'create.js'
	end

	def create
			@comment = @user.comments.new(comment_params)
	   		@comment.save
	   		load_comments
      	#redirect_back(fallback_location: project_path(@comment.project))
	end

	private

	def comment_params
		params.slice(:project_id).merge(params.require(:comment).permit(:body)).permit!
	end

	def load_entities
		@user = current_user
	end

	def load_comments
		@comments = Comment.where(project_id: params[:project_id]).order("id desc").limit(10).reverse
	end
end
