class ShortenUrl < ApplicationRecord
	
	validates :base_original_url, presence: true
	
	before_create :generate_short_url
	before_create :sanitize
	
	def generate_short_url
		self.minimized_url = "xxx"+rand(100).to_s
	end
	
	def sanitize
		self.base_original_url.strip!
		self.clean_url = self.base_original_url.downcase		
	end
	
	def find_duplicate
		ShortenUrl.find_by_clean_url(self.clean_url)
	end
	
	
	def new_url?
		find_duplicate.nil?
	end
	
	
	
end
