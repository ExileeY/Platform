class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :load_entities
  before_action :require_permission, only: [:edit, :destroy]

  def index
  	@projects = Project.order(created_at: :desc).all
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

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = "Changes saved"
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end

  def show
    @comments = Comment.all
    @project = Project.find(params[:id])
    if user_signed_in?
      @comment = @user.comments.new
    end
  end

  def destroy
    @project.destroy
    flash[:success] = "Project has been deleted"
    redirect_to profile_path(@user)
  end

  private
	  def project_params
	  	params.require(:project).permit(:title,:description,:image)
	  end

    def load_entities
      @project = Project.find_by(id: params[:id])
      @user = current_user
    end

    def require_permission
      if current_user != Project.find(params[:id]).user
        redirect_to project_path
      end
    end
end
