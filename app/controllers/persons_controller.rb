class PersonsController < ApplicationController
  before_action :authenticate_user!

  def profile
  	@projects = Project.all
	@user = User.find(params[:user_id])
	@user_projects = @user.projects
  end
end
