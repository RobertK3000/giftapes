class CreateCuratedListItems < ActiveRecord::Migration[6.0]
  def change
    create_table :curated_list_items do |t|
      t.string :prompt
      t.string :url
      t.references :curated_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
