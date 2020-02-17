module ProjectsHelper
	def current_user_has_review?
		Review.where(project_id: @project.id, user_id: current_user.id).exists?
	end

	def item_owner?(record)
		current_user == record.user
	end
end
