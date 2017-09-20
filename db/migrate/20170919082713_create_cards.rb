class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :original_text,   null: false
      t.string :translated_text, null: false
      t.date :review_date_on,    null: false

      t.timestamps
    end
  end
end
