class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :ticket, foreign_key: true
      t.references :owner, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
