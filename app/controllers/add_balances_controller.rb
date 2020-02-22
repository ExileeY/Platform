class AddBalancesController < ApplicationController
	before_action :load_user
	before_action :authenticate_user!

	def new
		@add_balance = @user.add_balances.new
	end

	def create
		@add_balance = @user.add_balances.new(add_balance_params)
		@user_balance = @user.balance
		@add_balance.save
		@user.update_attributes(balance: (@user_balance + @add_balance.money))
		redirect_to profile_path(@user)
	end

	private
		def load_user
			@user = current_user
		end

		def add_balance_params
			params.require(:add_balance).permit(:money)
		end
end
