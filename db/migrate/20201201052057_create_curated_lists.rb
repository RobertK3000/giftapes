class CreateCuratedLists < ActiveRecord::Migration[6.0]
  def change
    create_table :curated_lists do |t|

      t.timestamps
    end
  end
end
