class SchoolProgramsController < ApplicationController
	before_action :set_school_program, only: [:edit, :update, :destroy]

	def index
		@school_programs = SchoolProgram.all
	end

	def new
		@school_program = SchoolProgram.new
	end

	def create
		@school_program = SchoolProgram.new(school_program_params)

		respond_to do |format|
			if @school_program.save
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
		respond_to do |format|
			if @school_program.update(school_program_params)
				flash[:notice] = 'Successflly updated.'
				format.html { redirect_to action: :index }
			else
				format.html { render :edit, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		begin 
			@school_program.destroy!
			respond_to do |format|
				flash[:notice] = 'Successflly deleted.'
				format.html { redirect_to action: :index }
			end
		rescue
			respond_to do |format|
				flash[:notice] = @school_program.errors.full_messages.join('')
				format.html { redirect_to action: :index }
			end
		end
	end

	private

	def set_school_program
		@school_program = SchoolProgram.find(params[:id])
	end

	def school_program_params
		params.require(:school_program).permit(
			:name,
			:skill_khmer,
		)
	end
end