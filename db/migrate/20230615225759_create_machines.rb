class CreateMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :machines do |t|
      t.integer :client_id
      t.integer :processor_id
      t.integer :motherboard_id
      t.integer :graphic_card_id

      t.timestamps
    end
  end
end
