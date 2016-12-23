class AddPreviousStateRefToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :previous_state, foreign_key: {to_table: :states}
  end
end
