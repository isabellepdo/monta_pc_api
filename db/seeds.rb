# Products available at the Devise Informática store

# In the processor's model the brand is an enum, where 1 = Intel and 2 = AMD, so the array will be filled with this rule
array_processor = [['Core i5', 1], ['Core i7', 1], ['Ryzen 5', 2], ['Ryzen 7', 2]]
array_processor.each do |processor_data|
  Processor.create(product: processor_data[0], brand: processor_data[1])
end

# In the motherboard's model the supported_processors is an enum, where 1 = Intel and 2 = AMD and 99 = all, so the array will be filled with this rule
array_motherboard = [['Asus ROG', 1, 2, 16, false], ['Gigabyte Aorus', 2, 2, 16, false], ['ASRock Steel Legend', 99, 4, 64, true]]
array_motherboard.each do |motherboard_data|
  Motherboard.create(product: motherboard_data[0], supported_processors: motherboard_data[1], ram_slot: motherboard_data[2], ram_total: motherboard_data[3], integrated_video: motherboard_data[4])
end

array_ram_memory = [4,8,16,32,64]
array_ram_memory.each do |ram_memory_data|
  RamMemory.create(product: 'Kingston Hiper X', available_sizes: ram_memory_data)
end

array_graphic_card = ['Evga Geforce RTX 2060 6GB', 'Asus ROG Strix Geforce RTX 3060 6GB', 'Gigabyte Radeon RX 6600 XT EAGLE 8GB']
array_graphic_card.each do |graphic_card_data|
  GraphicCard.create(product: graphic_card_data)
end
