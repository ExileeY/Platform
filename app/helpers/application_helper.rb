module ApplicationHelper
	def current_user?(user)
		user == current_user
	end

	def user_admin?(user)
		user[:admin] == true
	end

	def user_owner?(user)
		user[:owner] == true
	end
end
