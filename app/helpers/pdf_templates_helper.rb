module PdfTemplatesHelper
	# ex. ០៤ មិនា ២០០៥
	def birthdate(date)
		ConvertKhmer::Date.khmer_date_simple(date)
	end

	# ex. ថ្ងេទី៨ ខែធ្នូ ឆ្នាំ២០២៥
	def start_date(date)
		ConvertKhmer::Date.khmer_date(date)
	end

	# ex. ថ្ងែទី៦ ខែមករា ឆ្នាំ២០២៥
	def expire_date(date)
		ConvertKhmer::Date.khmer_date(date)
	end

	# ex. ២០២៦-២០២៧
	def academic_year(student)
		ConvertKhmer::Date.khmer_number(student.academic_year_start) + "-" + ConvertKhmer::Date.khmer_number(student.academic_year_end)
	end
end