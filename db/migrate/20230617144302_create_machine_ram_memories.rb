class CreateMachineRamMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_ram_memories do |t|
      t.integer :ram_memory_id
      t.integer :machine_id

      t.timestamps
    end
  end
end
