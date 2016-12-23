class AddStateRefToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :state, foreign_key: true
  end
end
