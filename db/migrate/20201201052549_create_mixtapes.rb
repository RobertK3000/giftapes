class CreateMixtapes < ActiveRecord::Migration[6.0]
  def change
    create_table :mixtapes do |t|
      t.string :name
      t.string :theme_type

      t.timestamps
    end
  end
end
