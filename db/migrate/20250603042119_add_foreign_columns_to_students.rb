class AddForeignColumnsToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :school_program_id, :integer, null: true, limit: 4
    add_column :students, :study_level_id, :integer, null: true, limit: 4
    add_foreign_key :students, :school_programs
    add_foreign_key :students, :study_levels
  end
end
