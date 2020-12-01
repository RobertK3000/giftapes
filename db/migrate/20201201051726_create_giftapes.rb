class CreateGiftapes < ActiveRecord::Migration[6.0]
  def change
    create_table :giftapes do |t|
      t.references :giftable, polymorphic: true
      t.references :user, null: false, foreign_key: true
      t.string :url_token
      t.timestamp :finished_at

      t.timestamps
    end
  end
end
