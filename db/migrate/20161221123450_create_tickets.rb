class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :name
      t.text :description
      t.references :project, foreign_key: true
      t.references :owner, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
