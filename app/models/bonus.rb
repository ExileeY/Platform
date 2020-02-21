class Bonus < ApplicationRecord
	belongs_to :project
  	has_many :user_bonuses, dependent: :destroy
end
