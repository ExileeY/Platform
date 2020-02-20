class Event < ApplicationRecord
	belongs_to :user
	belongs_to :project
	mount_uploader :image, AvatarUploader
	validates :title, presence: true, length: {minimum:5}
	validates :body, presence: true
	validates :image, file_size: {less_than: 2.megabytes}
end
