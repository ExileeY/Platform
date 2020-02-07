class ProjectPolicy < ApplicationPolicy
	def index?
		true
	end

	def create?
		return true if user.present? && user == project.user
	end

	def update?
		return true if user.present? && user == project.user
	end

	def destroy?
    	return true if user.present? && user == project.user
  	end

  	private
 
	    def project
	      record
	    end
end