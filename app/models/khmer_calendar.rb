class KhmerCalendar < ApplicationRecord
	validates :khmer_calendar_text, presence: true

	before_update :update_students_khmer_calendar_text

	private

	def update_students_khmer_calendar_text
		students =
			Student.search_by_started_at(condition_year: year).
				where(started_at_khmer_calender: khmer_calendar_text_in_database)
		students.each do |student|
			student.started_at_khmer_calender = khmer_calendar_text
			student.save!
		end
	end
end
