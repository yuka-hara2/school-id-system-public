class AddClassNameAndStudentNumberToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :class_name, :string, null: true, limit: 50
    add_column :students, :student_number, :integer, null: false
  end
end
