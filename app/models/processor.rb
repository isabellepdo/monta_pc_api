class Processor < ApplicationRecord
	enum brand: {
		intel: 1,
		amd: 2
	}
end
