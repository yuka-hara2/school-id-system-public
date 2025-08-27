class CreateSchoolPrograms < ActiveRecord::Migration[8.0]
  def change
    create_table :school_programs do |t|
      t.string    :name,        null: false,  limit: 100
      t.string    :skill_khmer, null: false,  limit: 100
      t.timestamps
    end
  end
end
