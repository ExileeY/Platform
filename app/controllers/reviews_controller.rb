class ReviewsController < ApplicationController
  	before_action :authenticate_user!
	before_action :load_project
	
	def create
		if user_has_review?
			flash[:notice] = t("flash.reviews.create")
			redirect_to project_path(@project)
		else
			@review = current_user.reviews.new(review_params)
			@review.project_id = @project.id
			@review.save
			redirect_to project_path(@project)
		end
	end

	private
		def user_has_review?
			Review.where(project_id: @project.id, user_id: current_user.id).exists?
		end

		def review_params
			params.require(:review).permit(:rating)
		end

		def load_project
			@project = Project.find(params[:project_id])
		end
end
