class KhmerCalendarsController < ApplicationController
	before_action :set_khmer_calendar, only: [:edit, :update, :destroy]
	before_action :set_year_list, only: [:new, :edit, :create, :update] 

	def index
		@khmer_calendars = KhmerCalendar.all
	end

	def new
		@khmer_calendar = KhmerCalendar.new
		@khmer_calendar.year = Time.now.year
	end

	def create
		@khmer_calendar = KhmerCalendar.new(khmer_calendar_params)

		respond_to do |format|
			if @khmer_calendar.save
				flash[:notice] = 'Successflly created.'
				format.html { redirect_to action: :index }
			else
				format.html { render :new, status: :unprocessable_entity }
			end
		end
	end

	def edit
	end

	def update
		begin
			ActiveRecord::Base.transaction do
				@khmer_calendar.update!(khmer_calendar_params)
			end
			respond_to do |format|
				flash[:notice] = 'Successflly updated.'
				format.html { redirect_to action: :index }
			end
		rescue
			respond_to do |format|
				format.html { render :edit, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@khmer_calendar.destroy!

		respond_to do |format|
			flash[:notice] = 'Successflly deleted.'
			format.html { redirect_to action: :index }
		end
	end

	private

	def set_khmer_calendar
		@khmer_calendar = KhmerCalendar.find(params[:id])
	end

	def set_year_list
		@year_list = Student.academic_year_list
	end

	def khmer_calendar_params
		params.require(:khmer_calendar).permit(
			:year,
			:khmer_calendar_text,
		)
	end
end