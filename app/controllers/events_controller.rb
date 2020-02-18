class EventsController < ApplicationController
  	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :load_entities
	before_action :find_event, only: [:show,:edit,:update,:destroy]
	before_action :require_permission, only: [:new,:create,:edit,:update,:destroy]

	def new
		@event = @user.events.new
	end

	def create		
		@event = @user.events.new(event_params)
		@event.project = @project

		if @event.save
			redirect_to project_path(@project)
		else
			render 'new'
		end
	end

	def update
		if @event.update_attributes(event_params)
			redirect_to project_path(@project)
		else
			render 'edit'
		end
	end

	def destroy
		@event.destroy
		redirect_to project_path(@project)
	end

	private
		def event_params
			params.require(:event).permit(:title, :body, :image)
		end

		def find_event
			@event = Event.find(params[:id])
		end

		def load_entities
			@user = current_user
			@project = Project.find(params[:project_id])
		end

		def require_permission
			if @user.admin != true
		      if current_user != @project.user
		        redirect_to project_path(@project)
		      end
		  	end
    	end
end
