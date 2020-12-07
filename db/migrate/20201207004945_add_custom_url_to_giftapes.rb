class AddCustomUrlToGiftapes < ActiveRecord::Migration[6.0]
  def change
    add_column :giftapes, :custom_url, :string
  end
end
