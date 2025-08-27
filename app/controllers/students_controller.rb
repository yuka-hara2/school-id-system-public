class StudentsController < ApplicationController
	before_action :set_student, only: [:show, :edit, :update, :destroy]
	before_action :set_academic_year_list, only: [:new, :edit, :create, :update] 
	before_action :set_school_programs, only: [:index, :search, :new, :edit, :create, :update, :bulk_maintenance, :search_for_bulk_delete]
	before_action :set_khmer_calendar_list, only: [:new, :edit, :create, :update]
	before_action :set_study_levels, only: [:new, :edit, :create, :update]
	before_action :set_provinces, only: [:new, :edit, :create, :update]

	def index
		@search_condition_year_started_at = Date.today
		# search from beginning of this year to end of this year
		@students =
			Student.
				search_by_started_at(condition_year: @search_condition_year_started_at.year).
				includes(:school_program)
	end

	def search
		search_students
		respond_to do |format|
      format.html { render :index }
      format.pdf do
        send_data(generate_pdf(), filename: 'students_id_card.pdf', type: 'application/pdf')
      end
    end
	end

	def test_id_card
		search_students
		respond_to do |format|
      format.html { render 'pdf_templates/test_id_card' }
    end
	end

	def show
	end

	def new
		@student = Student.new
		@student.academic_year_start = Time.now.year
		@student.academic_year_end = Time.now.year + 2
		@student.started_at = Date.new(Time.now.year, 12, 1)
		@student.end_at = @student.started_at + 2.years - 1.day
		@student.birthdate = Time.now - 18.years 
	end

	def create
		@student = Student.new(student_params)

		respond_to do |format|
			if @student.save
				flash[:notice] = 'Student was successflly created.'
				format.html { redirect_to @student }
			else
				format.html { render :new, status: :unprocessable_entity }
			end
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if @student.update(student_params)
				flash[:notice] = 'Student was successflly updated.'
				format.html { redirect_to @student }
			else
				format.html { render :edit, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@student.destroy!

		respond_to do |format|
			flash[:notice] = 'Student was successflly deleted.'
			format.html { redirect_to action: :index }
		end
	end

	def bulk_maintenance
		@search_condition_year_started_at = Date.today
		@search_condition_created_date = Date.today
	end

	def import
		begin
			import_result, import_errors, imported_number =
				Student.import_csv(
					CSV.open(params[:imput_csv].path, "rb:BOM|UTF-8", headers: true)
				)
		rescue => e
			respond_to do |format|
				flash[:notice] = e.message
				format.html { redirect_to action: :bulk_maintenance }
			end
			return
		end

		respond_to do |format|
			if import_errors.present?
				notice_message = "Import failed for the following reasons.\n"
				import_errors.each do |row_num, joined_error_messages|
					notice_message += "Row of #{row_num}:\n"
					notice_message += joined_error_messages
				end
				flash[:notice] = notice_message
				format.html { redirect_to action: :bulk_maintenance }
			else
				flash[:notice] = "Number of #{imported_number} students data was imported."
				format.html { redirect_to action: :bulk_maintenance }
			end
		end
	end

	def export
		search_students
		send_data(
			FileUtils::CsvFile.set_bom(Student.csv_output(@students)),
			filename: "students.csv"
		)
	end

	def search_for_bulk_delete
		@search_condition_created_date = Date.new(params["[created_date(1i)]"].to_i, params["[created_date(2i)]"].to_i, params["[created_date(3i)]"].to_i)
		@search_condition_school_program = params[:school_program_id]
		summary =
			Student.search_and_get_students_summary_for_bulk_delete(
				condition_created_at: @search_condition_created_date,
				condition_school_program_id: @search_condition_school_program
			)
		@message_for_deleting_students =
			if summary.nil?
				"There are not any students match the condition."
			else
				"If you want to delete students as follows, push the Bulk Delete button.\n" + summary
			end
		unless summary.nil?
			@exist_target_student = true
			@created_date = @search_condition_created_date
			@school_program_id = @search_condition_school_program
		end

		respond_to do |format|
      format.html { render :bulk_maintenance }
    end
	end

	def bulk_delete
		Student.bulk_delete!(
			condition_created_at: params[:created_date].to_date,
			condition_school_program_id: params[:school_program_id]
		)

		respond_to do |format|
			flash[:notice_bulk_delete] = 'Students are successflly deleted.'
			format.html { redirect_to action: :bulk_maintenance }
		end
	end

	private

	def search_students
		# search from beginning of the year to end of this year
		@search_condition_year_started_at = Date.new(params["[year_started_at(1i)]"].to_i, 1, 1)
		@search_condition_month_started_at =
			unless params["[month_started_at(2i)]"].blank?
				Date.new(params["[year_started_at(1i)]"].to_i, params["[month_started_at(2i)]"].to_i, 1)
			end
		@search_condition_school_program = params[:school_program_id]

		@students = Student.search_by_started_at(
			condition_year: @search_condition_year_started_at.year,
			condition_month: @search_condition_month_started_at&.month
		)
		@students = @students.where(school_program_id: @search_condition_school_program) unless @search_condition_school_program.blank?
	end

	def generate_pdf
		html_content = render_to_string(
			template: 'pdf_templates/id_card',
			formats: [:html],
			layout: "pdf"
			)
		Grover.new(html_content, print_background: true).to_pdf
	end

	def set_student
		@student = Student.find(params[:id])
	end

	def student_params
		params.require(:student).permit(
			:name_khmer,
			:name_alphabet,
			:academic_year_start,
			:academic_year_end,
			:started_at_khmer_calender,
			:birthdate,
			:birth_place,
			:started_at,
			:end_at,
			:phone_number,
			:parent_name,
			:parent_phone_number,
			:school_program_id,
			:study_level_id,
			:profile_image,
			:gender,
		)
	end

	def set_academic_year_list
		@academic_year_list = Student.academic_year_list
	end

	def set_school_programs
		@school_programs = SchoolProgram.all
	end

	def set_khmer_calendar_list
		@khmer_calendar_list = KhmerCalendar.all.order(updated_at: :desc).pluck(:khmer_calendar_text)
	end

	def set_study_levels
		@study_levels = StudyLevel.all
	end

	def set_provinces
		@provinces = PlacesInKhmer::Provinces::PROVINCES
	end
end