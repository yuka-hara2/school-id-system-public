module PlacesInKhmer
	class Provinces
		PROVINCES = %w(ភ្នំពេញ កណ្តាល កំពង់ចាម កំពង់ឆ្នាំង កំពង់ស្ពឺ កំពត កោះកុង ក្រចេះ ត្បូងឃ្មុំ បន្ទាយមានជ័យ បាត់ដំបង ប៉ៃលិន ពោធិ៍សាត់ ព្រៃវែង ព្រះសីហនុ ព្រះវិហារ មណ្ឌលគិរី រតនគិរី សៀមរាប ស្ទឹងត្រែង ស្វាយរៀង តាកែវ ឧត្តរមានជ័យ កែប)

		class << self
			def correct_province?(str)
				PROVINCES.index(str)
			end
		end
	end
end
