class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :load_entities
  before_action :require_permission, only: [:edit, :destroy]

  def index
    if cookies[:rating_sort]
      @projects = Project.includes(:reviews).order("reviews.rating desc").paginate(page: params[:page], per_page: 30)
    elsif cookies[:updated_at_sort]
      @projects = Project.order(updated_at: :desc).paginate(page: params[:page], per_page: 30)
    else
      @projects = Project.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
    end
  end

  def new
    @project = @user.projects.new
    @project_image = @project.project_images.build
    @project_bonuse = @project.bonuses.build
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
    @events = @project.events.all
    @project_images = @project.project_images.all
    @project = Project.find(params[:id])
    @project_owner = @project.user
    @bonuses = @project.bonuses
    if user_signed_in?
      @comment = @user.comments.new
      @review = @user.reviews.new
      @user_review = @project.reviews.find_by(user_id: @user.id)
    end
  end

  def destroy
    @project.destroy
    flash[:success] = "Project has been deleted"
    redirect_to profile_path(@user)
  end

  def rating_sort
    if cookies[:updated_at_sort]
      cookies.delete :updated_at_sort
    end
    cookies[:rating_sort] = {
      value:"Sort by rating"
    }
    redirect_to projects_path
  end

  def updated_at_sort
    if cookies[:rating_sort]
      cookies.delete :rating_sort
    end
    cookies[:updated_at_sort] = {
      value:"Sort by updated projects"
    }
    redirect_to projects_path
  end

  def created_at_sort
    if cookies[:rating_sort]
      cookies.delete :rating_sort
    elsif cookies[:updated_at_sort]
      cookies.delete :updated_at_sort
    end
    redirect_to projects_path
  end

  private
    def project_params
      params.require(:project).permit(:title,:description, :theme, :tag, 
                                      :video_url, :money_donated, :money_need, 
                                      :end_date, project_images_attributes:[:id, :project_id, :image], 
                                      bonuses_attributes:[:id, :project_id, :user_id, :name, :description, :price, :_destroy])
    end

    def load_entities
      @project = Project.find_by(id: params[:id])
      @user = current_user
    end

    def require_permission
      if @user.admin != true
        if current_user != Project.find(params[:id]).user
          redirect_to project_path(@project)
        end
      end
    end
end
