class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :project
	has_many :likes, dependent: :destroy
	validates :body, presence:true, allow_blank:false
end
