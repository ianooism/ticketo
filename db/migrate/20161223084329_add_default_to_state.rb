class AddDefaultToState < ActiveRecord::Migration[5.0]
  def change
    add_column :states, :default, :boolean, default: false
  end
end
