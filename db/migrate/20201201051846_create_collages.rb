class CreateCollages < ActiveRecord::Migration[6.0]
  def change
    create_table :collages do |t|

      t.timestamps
    end
  end
end
