class AddColumnsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment_mode, :integer
    add_column :orders, :payment_id, :string
    add_column :orders, :payment_status, :integer
    add_column :orders, :delivery_status, :integer
  end
end
