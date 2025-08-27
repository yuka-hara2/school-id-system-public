class SchoolProgram < ApplicationRecord
	has_many :students

	validates :name, presence: true
	validates :skill_khmer, presence: true

	before_destroy :validate_before_destroy

	private

	def validate_before_destroy
		errors.add(:base, 'The Program cannot be deleted. Because it is used by some student data.') if students.exists?
	end
end
