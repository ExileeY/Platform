class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :load_entities

  def index
  	@projects = Project.all
  end

  def new
  	@project = @user.projects.new
  end

  def create
  	@project = @user.projects.new(project_params)
  	if @project.save
  		flash[:success] = "Your project has been saved"
  		redirect_to project_path(@project)
  	else
  		render 'new'
  	end
  end

  def show
  	@project = Project.find(params[:id])
  end

  private
	  def project_params
	  	params.require(:project).permit(:title,:description,:image)
	  end

    def load_entities
      @user = current_user
    end
end
