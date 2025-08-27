class CreateStudyLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :study_levels do |t|
      t.string    :name,        null: false,  limit: 100
      t.string    :name_khmer,  null: false,  limit: 100
      t.timestamps
    end
  end
end
