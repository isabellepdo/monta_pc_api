class CreateRamMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :ram_memories do |t|
      t.string :product
      t.integer :available_sizes

      t.timestamps
    end
  end
end
