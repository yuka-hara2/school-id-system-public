class AddGenderToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :gender, :integer, default: 0, limit: 1
  end
end
