class PersonsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_entities
  before_action :require_owner_permission, only: [:take_away_permission]
  before_action :require_admin_permission, only: [:give_permission, :ban, :unban, :delete_user]
  before_action :current_user_unbanned, :current_user_banned, only: [:ban_page]

  def profile
	  @user_projects = @user.projects
  end

  def give_permission
  	@user.update(admin:true)
  	redirect_to profile_path(@user)
  end

  def take_away_permission
  	@user.update(admin:false)
  	redirect_to profile_path(@user)
  end

  def ban
  	@user.update(banned:true)
  	redirect_to profile_path(@user)
  end

  def ban_page
  end

  def unban
  	@user.update(banned:false)
  	redirect_to profile_path(@user)
  end

  def delete_user
    @user.destroy
    redirect_to root_path
  end

  def new_user_project
    @project = @user.projects.new
    @project_image = @project.project_images.build
  end

  def create_user_project
    @project = @user.projects.new(params.require(:project).permit(:title,:description, :theme, :tag, :video_url, project_images_attributes:[:id, :project_id, :image]))
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

  private
  	def load_entities
  		@user = User.find(params[:id])
  	end

    def current_user_banned
      if current_user.banned == true && @user != current_user
        redirect_to ban_page_path(current_user)
      end
    end

    def current_user_unbanned
      if current_user.banned == false
        redirect_to root_path
      end
    end

  	def require_admin_permission
  		if current_user.admin != true
  			redirect_to root_path
  		end
  	end

  	def require_owner_permission
  		if current_user.owner != true
  			redirect_to root_path
  		end
  	end
end
