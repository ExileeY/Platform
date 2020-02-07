class ProjectImage < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :project
	validates :image, file_size: {less_than: 2.megabytes}
end
