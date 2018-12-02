require "base64"
class ShortenUrl < ApplicationRecord
	
	validates :base_original_url, presence: true
	
	before_create :generate_short_url
	before_create :sanitize
	
	def generate_short_url
		chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map { |range| range.to_a }.flatten
		generated_url = 6.times.map { chars.sample }.join
		old_url = ShortenUrl.where(minimized_url: generated_url).last
		if old_url.present?
			self.generate_short_url
		else
			self.minimized_url = generated_url
		end
		#self.minimized_url = Base64.encode64(self.base_original_url).strip!
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
