class CommentsController < ApplicationController
	before_action :load_entities
	def create
			@comment = @user.comments.new(comment_params)
	   		@comment.save
	   		@comments = Comment.where(project_id: @comment.project_id)
      	#redirect_back(fallback_location: project_path(@comment.project))
	end

	private

	def comment_params
		params.slice(:project_id).merge(params.require(:comment).permit(:body)).permit!
	end

	def load_entities
		@user = current_user
	end
end
