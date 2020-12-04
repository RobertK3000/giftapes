class AddNameToCollages < ActiveRecord::Migration[6.0]
  def change
    add_column :collages, :name, :string
  end
end
