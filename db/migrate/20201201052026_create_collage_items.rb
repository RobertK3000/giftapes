class CreateCollageItems < ActiveRecord::Migration[6.0]
  def change
    create_table :collage_items do |t|
      t.references :collage, null: false, foreign_key: true
      t.string :prompt

      t.timestamps
    end
  end
end
