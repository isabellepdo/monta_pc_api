class Machine < ApplicationRecord
	belongs_to :processor
	belongs_to :motherboard

	has_many :machine_ram_memories, dependent: :destroy
	has_many :ram_memories, through: :machine_ram_memories
	has_one :graphic_card

	validate :is_motherboard_compatible_with_processor
	validate :are_memories_compatible

	validates_presence_of :processor_id, message: "The machine must contain 1 Processor."
	validates_presence_of :motherboard_id, message: "The machine must contain 1 Motherboard."
	validates_presence_of :graphic_card_id, if: Proc.new{!self.motherboard.integrated_video?} , message: "The machine needs a Graphic Card."

	def is_motherboard_compatible_with_processor
		unless self.motherboard.processor_valids.include?self.processor
			errors.add(:base, "Motherboard is not compatible with Processor.")
		end
	end

	def are_memories_compatible
		if self.machine_ram_memories.empty?
			errors.add(:base, "The machine needs at least 1 RAM memory.")
		end

		if self.motherboard.ram_slot < self.machine_ram_memories.size
			errors.add(:base, "Motherboard doesn't have enough slots for RAM.")
		end

		total_available_sizes_of_ram = self.machine_ram_memories.map { |mrm| mrm.ram_memory.available_sizes }.sum
		if self.motherboard.ram_total < total_available_sizes_of_ram
			errors.add(:base, "The motherboard does not support these RAM memories.")
		end
	end
end
