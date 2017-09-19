class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :original_text
      t.string :translated_text
      t.date :review_date_on

      t.timestamps
    end
  end
end
