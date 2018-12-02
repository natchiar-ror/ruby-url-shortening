class ShortenedUrlsController < ApplicationController
	
	before_action :find_url, only: [:show, :shortened]
	skip_before_action :verify_authenticity_token
	
	def index
		@url = ShortenUrl.new
	end
	
	def new
		redirect_to @url.clean_url

	end
	
	def create
		@domain = request.protocol+request.host_with_port
		@url = ShortenUrl.new
		@url.base_original_url = params[:base_original_url]
		@url.sanitize
		
		respond_to do |format|
			if @url.new_url?
				if @url.save 
					@flag = false
					#redirect_to shortened_path(@url.minimized_url)
					format.js {}
				else
					flash[:error] = "Check the error below"
					format.html{ render 'index'}
				end
			else
				@flag = true
				flash[:notice] = "Short link for the given url is already available"
				#redirect_to shortened_path(@url.find_duplicate.minimized_url)
				format.js {}
			end
		end
	
	end
	
	def shortened
		@url = ShortenUrl.find_by_minimized_url(params[:minimized_url])
		redirect_to @url.base_original_url
	end
	
	
	private
	def find_url
		@url = ShortenUrl.find_by_minimized_url(params[:minimized_url])
	end
	
end
