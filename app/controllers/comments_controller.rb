class CommentsController < ApplicationController
	before_action :load_entities
	def create
		@comment = @user.comments.new(comment_params)
   		@comment.project = Project.find(params[:project_id])
   		@comment.save
      	redirect_back(fallback_location: project_path(@comment.project))
	end

	private

	def comment_params
		params.require(:comment).permit(:body, :user_id)
	end

	def load_entities
		@user = current_user
	end
end
