class AddWifiToVenue < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :wifi, :float
  end
end
