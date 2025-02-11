class ProjectImagesController < ApplicationController
	before_action :authenticate_user!
	before_action :load_before
	before_action :require_permission, only: [:edit]

	def edit
	end

	def update
		if current_user == @project_owner || admin?
			if @project_image.update_attributes(project_image_params)
				flash[:success] = t("flash.project_images.update")
				redirect_to @project_image.project
			else
				render 'edit'
			end
		end
	end

	def destroy
		@project_image.destroy
		redirect_to @project_image.project
	end

	private
		def load_before
			@project_image = ProjectImage.find(params[:id])
			@project = @project_image.project
      		@project_owner = @project.user
		end

		def require_permission
			if !admin?
		      if current_user != @project_image.project.user
		        redirect_to project_path(@project)
		      end
		  	end
	    end

		def project_image_params
			params.require(:project_image).permit(:image)
		end

		def admin?
			current_user.admin == true
		end
end
