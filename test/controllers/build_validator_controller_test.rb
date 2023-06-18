require 'test_helper'

class BuildValidatorControllerTest < ActionDispatch::IntegrationTest
	test "should validate build with valid data" do
		processor = Processor.create(product: 'Core i5', brand: :intel)
		motherboard = Motherboard.create(product: 'Asus ROG', supported_processors: :intel , ram_slot: 2, ram_total: 64, integrated_video: true)
		ram_memory = RamMemory.create(product: 'Kingston Hiper X', available_sizes: 2)
		
		params = {
			processor: processor.id,
			motherboard: motherboard.id,
			ram_memories: [ram_memory.id],
			client_id: 1
		}

		post validate_build_url, params: params.to_json, headers: { 'Content-Type': 'application/json' }
		
		assert_response :success
		assert JSON.parse(response.body)["valid"]
	end

	test "must validate compilation with invalid data - needs a Graphic Card" do
		processor = Processor.create(product: 'Core i5', brand: :intel)
		motherboard = Motherboard.create(product: 'Asus ROG', supported_processors: :intel , ram_slot: 2, ram_total: 64, integrated_video: false)
		ram_memory = RamMemory.create(product: 'Kingston Hiper X', available_sizes: 2)
		
		params = {
			processor: processor.id,
			motherboard: motherboard.id,
			ram_memories: [ram_memory.id],
			client_id: 1
		}

		post validate_build_url, params: params.to_json, headers: { 'Content-Type': 'application/json' }

		assert_response :success
		assert_not JSON.parse(response.body)["valid"]
		assert_not_empty JSON.parse(response.body)["errors"]
		assert_includes JSON.parse(response.body)["errors"], "Graphic card The machine needs a Graphic Card."
	end

	test "must validate compilation with invalid data - Motherboard is not compatible with Processor" do
		processor = Processor.create(product: 'Core i5', brand: :intel)
		motherboard = Motherboard.create(product: 'Asus ROG', supported_processors: :amd , ram_slot: 2, ram_total: 64, integrated_video: true)
		ram_memory = RamMemory.create(product: 'Kingston Hiper X', available_sizes: 2)
		
		params = {
			processor: processor.id,
			motherboard: motherboard.id,
			ram_memories: [ram_memory.id],
			client_id: 1
		}

		post validate_build_url, params: params.to_json, headers: { 'Content-Type': 'application/json' }

		assert_response :success
		assert_not JSON.parse(response.body)["valid"]
		assert_not_empty JSON.parse(response.body)["errors"]
		assert_includes JSON.parse(response.body)["errors"], "Motherboard is not compatible with Processor."
	end

	test "must validate compilation with invalid data - Needs RAM memory" do
		processor = Processor.create(product: 'Core i5', brand: :intel)
		motherboard = Motherboard.create(product: 'Asus ROG', supported_processors: :amd , ram_slot: 2, ram_total: 64, integrated_video: true)
		
		params = {
			processor: processor.id,
			motherboard: motherboard.id,
			client_id: 1
		}

		post validate_build_url, params: params.to_json, headers: { 'Content-Type': 'application/json' }

		assert_response :success
		assert_not JSON.parse(response.body)["valid"]
		assert_not_empty JSON.parse(response.body)["errors"]
		assert_includes JSON.parse(response.body)["errors"], "The machine needs at least 1 RAM memory."
	end

	test "must validate compilation with invalid data - Slot of RAM Memory" do
		processor = Processor.create(product: 'Core i5', brand: :intel)
		motherboard = Motherboard.create(product: 'Asus ROG', supported_processors: :intel , ram_slot: 1, ram_total: 64, integrated_video: false)
		ram_memory_1 = RamMemory.create(product: 'Kingston Hiper X', available_sizes: 2)
		ram_memory_2 = RamMemory.create(product: 'Kingston Hiper X', available_sizes: 4)
		
		params = {
			processor: processor.id,
			motherboard: motherboard.id,
			ram_memories: [ram_memory_1.id, ram_memory_2.id],
			client_id: 1
		}

		post validate_build_url, params: params.to_json, headers: { 'Content-Type': 'application/json' }

		assert_response :success
		assert_not JSON.parse(response.body)["valid"]
		assert_not_empty JSON.parse(response.body)["errors"]
		assert_includes JSON.parse(response.body)["errors"], "Motherboard doesn't have enough slots for RAM."
	end

	test "must validate compilation with invalid data - motherboard does not support all RAM memories" do
		processor = Processor.create(product: 'Core i5', brand: :intel)
		motherboard = Motherboard.create(product: 'Asus ROG', supported_processors: :intel , ram_slot: 1, ram_total: 4, integrated_video: false)
		ram_memory_1 = RamMemory.create(product: 'Kingston Hiper X', available_sizes: 2)
		ram_memory_2 = RamMemory.create(product: 'Kingston Hiper X', available_sizes: 4)
		
		params = {
			processor: processor.id,
			motherboard: motherboard.id,
			ram_memories: [ram_memory_1.id, ram_memory_2.id],
			client_id: 1
		}

		post validate_build_url, params: params.to_json, headers: { 'Content-Type': 'application/json' }

		assert_response :success
		assert_not JSON.parse(response.body)["valid"]
		assert_not_empty JSON.parse(response.body)["errors"]
		assert_includes JSON.parse(response.body)["errors"], "The motherboard does not support these RAM memories."
	end
end
