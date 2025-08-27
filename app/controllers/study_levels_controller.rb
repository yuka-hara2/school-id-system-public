class StudyLevelsController < ApplicationController
	before_action :set_study_level, only: [:edit, :update, :destroy]

	def index
		@study_levels = StudyLevel.all
	end

	def new
		@study_level = StudyLevel.new
	end

	def create
		@study_level = StudyLevel.new(study_level_params)

		respond_to do |format|
			if @study_level.save
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
			if @study_level.update(study_level_params)
				flash[:notice] = 'Successflly updated.'
				format.html { redirect_to action: :index }
			else
				format.html { render :edit, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		begin 
			@study_level.destroy!
			respond_to do |format|
				flash[:notice] = 'Successflly deleted.'
				format.html { redirect_to action: :index }
			end
		rescue
			respond_to do |format|
				flash[:notice] = @study_level.errors.full_messages.join('')
				format.html { redirect_to action: :index }
			end
		end
	end

	private

	def set_study_level
		@study_level = StudyLevel.find(params[:id])
	end

	def study_level_params
		params.require(:study_level).permit(
			:name,
			:name_khmer,
		)
	end
end