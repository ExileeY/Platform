class UserBonus < ApplicationRecord
	belongs_to :user
	belongs_to :bonus
end
