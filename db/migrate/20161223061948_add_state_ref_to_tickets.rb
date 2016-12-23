class AddStateRefToTickets < ActiveRecord::Migration[5.0]
  def change
    add_reference :tickets, :state, foreign_key: true
  end
end
