class Project < ApplicationRecord
	belongs_to :user
  	has_many :comments, dependent: :destroy
  	has_many :project_images, dependent: :destroy
  	accepts_nested_attributes_for :project_images
	validates :title, presence: true, length: {minimum: 5}
	validates :description, presence: true
end
