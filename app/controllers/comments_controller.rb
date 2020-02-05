class CommentsController < ApplicationController
	before_action :load_entities
	def create
		@comment = @user.comments.new(comment_params)
   		@comment.project = Project.find(params[:project_id])
   		@comment.save
      	redirect_to project_path(@comment.project)
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

	def load_entities
		@user = current_user
	end
end
