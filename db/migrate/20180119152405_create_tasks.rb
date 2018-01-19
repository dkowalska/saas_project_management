class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :status
      t.integer :priority
      t.references :project, foreign_key: true
      t.references :tenant, foreign_key: true

      t.timestamps
    end
  end
end
