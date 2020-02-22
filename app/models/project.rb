class Project < ApplicationRecord
	after_initialize :set_defaults
	acts_as_taggable_on :tags
	belongs_to :user
  	has_many :comments, dependent: :destroy
  	has_many :project_images, dependent: :destroy
  	has_many :reviews, dependent: :destroy
 	has_many :events, dependent: :destroy
 	has_many :bonuses, dependent: :destroy
 	has_many :transactions, dependent: :destroy
  	accepts_nested_attributes_for :project_images
  	accepts_nested_attributes_for :bonuses, allow_destroy:true, reject_if: proc {|att| att[:name].blank? || att[:description].blank? || att[:price].blank?}
	validates :title, presence: true, length: {minimum: 5}
	validates :description, presence: true
	validates :end_date, presence: true
	validates :money_need, presence: true

	def set_defaults
	   self.money_donated = 0 if self.new_record?
	end
end
