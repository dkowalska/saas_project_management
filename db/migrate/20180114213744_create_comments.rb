class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.boolean :client_comm
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.references :tenant

      t.timestamps
    end
  end
end
