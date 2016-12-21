class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.references :owner, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
