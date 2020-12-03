class AddLetterToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :letter, :integer
  end
end
