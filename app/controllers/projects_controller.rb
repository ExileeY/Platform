class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :load_entities
  before_action :require_permission, only: [:edit, :destroy]

  def index
    @projects = Project.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
  end

  def new
    @project = @user.projects.new
    @project_image = @project.project_images.build
  end

  def create
    @project = @user.projects.new(project_params)
    if @project.save
      if params[:project_images] != nil
        params[:project_images]['image'].each do |image|
            @project.project_images.create!(:image => image, :project_id => @project.id)
        end
      end
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
    @comments = @project.comments.all.order("id desc").limit(10).reverse
    @project_images = @project.project_images.all
    @project = Project.find(params[:id])
    @project_owner = @project.user
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
      params.require(:project).permit(:title,:description, :theme, :tag, :video_url, project_images_attributes:[:id, :project_id, :image])
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
