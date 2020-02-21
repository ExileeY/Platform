class UserBonusesController < ApplicationController
	before_action :load_entities
	before_action :user_exist
	before_action :user_has_bonuse, only: [:create]

	def create
		@balance = @user.balance
		@price = @bonus.price
		if @balance < @price
			flash[:notice] = "Недостаточно средств в кошельке"
			redirect_to profile_path(@user)
		else
			@money_donated = @project.money_donated
			@user.update_attributes(balance: @balance - @price)
			@project.update_attributes(money_donated: @money_donated + @price)
			@user.user_bonuses.create(bonus_id: @bonus.id)
			redirect_to project_path(@project)
		end
	end

	private
		def user_has_bonuse
			if UserBonus.where(user_id: @user.id, bonus_id: @bonus.id).exists?
				flash[:notice] = "You already have this bonus!"
				redirect_to profile_path(@user)
			end
		end

		def load_entities
			@user = current_user
			@bonus = Bonus.find(params[:bonus_id])
			@project = @bonus.project
		end

		def user_exist
			if @user.nil?
				flash[:notice] = "Войдите в аккаунт"
				redirect_to new_user_session_path
			end
		end
end
