class CreateGraphicCards < ActiveRecord::Migration[5.2]
  def change
    create_table :graphic_cards do |t|
      t.string :product

      t.timestamps
    end
  end
end
