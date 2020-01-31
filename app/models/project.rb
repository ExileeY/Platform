class Project < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :user
	validates :title, presence: true, length: {minimum: 5}
	validates :description, presence: true
	validates :image, file_size: {less_than: 1.megabytes}

end
