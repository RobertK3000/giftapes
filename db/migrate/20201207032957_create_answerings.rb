class CreateAnswerings < ActiveRecord::Migration[6.0]
  def change
    create_table :answerings do |t|
      t.references :quiz_session, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
