class ApplicationController < ActionController::Base
	include Pundit
  	protect_from_forgery
	before_action :user_banned, only: [:index,:new,:create,:edit,:update,:show,:profile,:new_user_project]
	before_action :configure_permitted_parameters, if: :devise_controller?

	def moon
		cookies[:moon] = {value: "dark mode on"}
		if user_signed_in?
			redirect_to profile_path(current_user)
		else
			redirect_to root_path
		end
	end

	def sun
		cookies.delete(:moon)
		if user_signed_in?
			redirect_to profile_path(current_user)
		else
			redirect_to root_path
		end
	end

	protected

		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
			devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password])
		end

		def user_banned
			if user_signed_in? && current_user.banned == true
				render "persons/ban_page"
			end
		end
end
