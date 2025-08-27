class StudyLevel < ApplicationRecord
	has_many :students

	validates :name, presence: true
	validates :name_khmer, presence: true

	before_destroy :validate_before_destroy

	private

	def validate_before_destroy
		errors.add(:base, 'The study level cannot be deleted. Because it is used by some student data.') if students.exists?
	end
end
