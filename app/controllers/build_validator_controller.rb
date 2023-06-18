class BuildValidatorController < ApplicationController
	def get_list_processors
		processors = Processor.all
		render json: processors
	end

	def get_list_motherboards
		motherboards = Motherboard.all
		render json: motherboards
	end

	def get_list_ram_memories
		ram_memories = RamMemory.all
		render json: ram_memories
	end

	def get_list_graphic_cards
		graphic_cards = GraphicCard.all
		render json: graphic_cards
	end

	def get_list_valid_machines
		sql_busca_machines = 'machines.id is not null '

		sql_busca_machines << 'AND machines.client_id = ' + params[:client_id].to_s if params[:client_id].present?
		sql_busca_machines << 'AND machines.processor_id = ' + params[:processor_id].to_s if params[:processor_id].present?
		sql_busca_machines << 'AND machines.motherboard_id = ' + params[:motherboard_id].to_s if params[:motherboard_id].present?
		sql_busca_machines << 'AND machines.graphic_card_id = ' + params[:graphic_card_id].to_s if params[:graphic_card_id].present?
		sql_busca_machines << 'AND machine_ram_memories.ram_memory_id = ' + params[:ram_memory_id].to_s if params[:ram_memory_id].present?

		machine = Machine.joins(:machine_ram_memories).where(sql_busca_machines).all

		render json: machine
	end

	def validate_build
		json_data = JSON.parse(request.body.read)
		
		processor_id = json_data['processor']
		motherboard_id = json_data['motherboard']
		ram_memory_ids = json_data['ram_memories']
		graphic_card_id = json_data['graphic_card']
		client_id = json_data['client_id']

		processor = Processor.find_by(id: processor_id)
		motherboard = Motherboard.find_by(id: motherboard_id)
		graphic_card = GraphicCard.find_by(id: graphic_card_id)

		machine = Machine.new(
			client_id: client_id,
			processor: processor,
			motherboard: motherboard,
			graphic_card: graphic_card
		)

		unless ram_memory_ids.nil?
			ram_memory_ids.each do |ram_memory_id|
				ram_memory = RamMemory.find_by(id: ram_memory_id)
				machine.machine_ram_memories.build(ram_memory: ram_memory) if ram_memory
			end
		end

		if machine.save
			render json: { valid: true }
		else
			render json: { valid: false, errors: machine.errors.full_messages }
		end
	end
end


