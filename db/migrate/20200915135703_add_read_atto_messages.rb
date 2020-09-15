class AddReadAttoMessages < ActiveRecord::Migration[6.0]
  def change
  	add_column :messages, :read_at, :datetime
  end
end
