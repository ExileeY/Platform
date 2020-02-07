class PersonsController < ApplicationController
  before_action :authenticate_user!

  def profile
	@user = User.find(params[:id])
	@user_projects = @user.projects
  end
end
