class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string    :name_khmer,          null: false,  limit: 100
      t.string    :name_alphabet,       null: false,  limit: 100
      t.string    :student_school_id,   null: true,   limit: 100
      t.date      :birthdate,           null: true
      t.string    :birth_place,         null: true,   limit: 100
      t.datetime  :started_at,          null: true
      t.datetime  :end_at,              null: true
      t.string    :photo_path,          null: true,   limit: 300
      t.string    :phone_number,        null: true,   limit: 20
      t.string    :parent_name,         null: true,   limit: 100
      t.string    :parent_phone_number, null: true,   limit: 20
      t.timestamps
    end
    add_index :students, :name_khmer
    add_index :students, :name_alphabet
    add_index :students, :student_school_id,  unique: true
  end
end
