class AddColumnsToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :academic_year_start, :integer, null: true, limit: 2
    add_column :students, :academic_year_end, :integer, null: true, limit: 2
    add_column :students, :started_at_khmer_calender, :string, null: true, limit: 100
  end
end
