class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.references :mixtape, null: false, foreign_key: true
      t.string :youtube_url
      t.integer :start_time
      t.integer :end_time
      t.integer :order

      t.timestamps
    end
  end
end
