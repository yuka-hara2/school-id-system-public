module ConvertKhmer
	class Date
		MONTH = %w(NONE មករា កុម្ភៈ មិនា មេសា ឧសភា មិថុនា កក្កដា សីហា កញ្ញា តុលា វិច្ឆិកា ធ្នូ)
		WEEK_DAYS = %w(ថ្ងៃអាទិត្យ ថ្ងៃច័ន្ទ ថ្ងៃអង្គារ ថ្ងៃពុធ ថ្ងៃព្រហស្បតិ៍ ថ្ងៃសុក្រ ថ្ងៃសៅរ៍)
		DATE_NAME = "ថ្ងៃ"
		MONTH_NAME = "ខែ"
		YEAR_NAME = "ឆ្នាំ"
		private_constant :MONTH, :WEEK_DAYS, :DATE_NAME, :MONTH_NAME, :YEAR_NAME

		class << self
			def khmer_number(num)
				return unless num

				num.to_s.tr('1234567890', '១២៣៤៥៦៧៨៩០')
			end

			def convert_khmer_number_to_number(str)
				return unless str

				str.tr('១២៣៤៥៦៧៨៩០', '1234567890').to_i
			end

			# ex. ០៣
			def khmer_dd(date)
				("០" + khmer_number(date.day.to_s))[-2, 2]
			end

			# ex. ថ្ងៃទី៨
			def khmer_day(date)
				DATE_NAME + khmer_number(date.day)
			end

			# ex. ខែធ្នូ
			def khmer_month(date)
				MONTH[date.month]
			end

			# ex. ឆ្នាំ២០២៥
			def khmer_year(date)
				YEAR_NAME + khmer_number(date.year)
			end

			# ex. ថ្ងៃទី៨ ខែធ្នូ ឆ្នាំ២០២៥
			def khmer_date(date)
				khmer_day(date) + " " + MONTH_NAME + khmer_month(date) + " " + khmer_year(date)
			end

			# ex. ០៤ មិនា ២០០៥
			def khmer_date_simple(date)
				khmer_dd(date) + " " + khmer_month(date) + " " + khmer_number(date.year)
			end

			def convert_khmer_date_simple_to_date(str)
				return unless str

				khmer_day, khmer_month, khmer_year = str.split(" ")
				return unless khmer_day.present? && khmer_month.present? && khmer_year.present?

				date =
					begin
						::Date.new(
							convert_khmer_number_to_number(khmer_year),
							MONTH.index(khmer_month),
							convert_khmer_number_to_number(khmer_day)
						)
					rescue
						return nil
					end

				date > ::Date.new(1900, 1, 1) ? date : nil
			end
		end
	end
end