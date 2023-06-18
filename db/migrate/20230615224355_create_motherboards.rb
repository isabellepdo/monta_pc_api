class CreateMotherboards < ActiveRecord::Migration[5.2]
  def change
    create_table :motherboards do |t|
      t.string :product
      t.integer :supported_processors
      t.integer :ram_slot
      t.integer :ram_total
      t.boolean :integrated_video

      t.timestamps
    end
  end
end
