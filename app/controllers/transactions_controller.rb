class TransactionsController < ApplicationController
	before_action :load_entities
	before_action :user_exist

	def new
		@donate = @user.transactions.new
	end

	def create
		@donate = @user.transactions.new(transaction_params)
		@donate.project = @project
		@user_balance = @user.balance
		@project_money = @project.money_donated
		if @user_balance < @donate.money
			render 'new'
		else
			ActiveRecord::Base.transaction do
				@donate.save
				@project_donate = @donate.money
				@user.update_attributes(balance: (@user_balance - @project_donate))
				@project.update_attributes(money_donated: @project_money + @project_donate )
				redirect_to @project
			end
		end
	end

	private
		def load_entities
			@user = current_user
			@project = Project.find(params[:project_id])
		end

		def user_exist
			if @user.nil?
				redirect_to root_path
			end
		end

		def transaction_params
			params.require(:transaction).permit(:money)
		end
end
