class AddNameToQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_column :quizzes, :name, :string
  end
end
