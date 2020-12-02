class AddNameToCuratedList < ActiveRecord::Migration[6.0]
  def change
    add_column :curated_lists, :name, :string
  end
end
