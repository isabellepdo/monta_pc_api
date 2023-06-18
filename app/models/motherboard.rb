class Motherboard < ApplicationRecord
	enum supported_processors: {
		intel: 1,
		amd: 2,
		all_of: 99
	}

	def processor_valids
		if self.intel?
			Processor.where(brand: :intel)
		elsif self.amd?
			Processor.where(brand: :amd)
		else
			Processor.all
		end
	end
end
