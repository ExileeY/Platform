class CommentsController < ApplicationController
  	before_action :authenticate_user!, only: [:create]
	before_action :load_entities
	before_action :require_permission, only:[:edit, :update, :destroy]


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

	def edit
		@comment = Comment.find(params[:id])
		@project = @comment.project
	end

	def update
		@comment = Comment.find(params[:id])
		@project = @comment.project
		if @comment.update_attributes(comment_params)
			flash[:success] = "Comment has been updated"
			redirect_to project_path(@project)
		else
			render 'edit'
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
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

	def require_permission
      if current_user != Comment.find(params[:id]).user
        redirect_to project_path(Comment.find(params[:id]).project)
      end
    end
end
