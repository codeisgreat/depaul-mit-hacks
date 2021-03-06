require 'rest-client'

class UploadController < ApplicationController
	def upload
	end

	def submit
		url = params[:url]
		event_id = params[:event_id]
		name = params[:name]

		response = RestClient.get("http://api.shabz.co/hackathon/get_page_count.php?url=http://docs.google.com/gview?url=#{url}&embedded=true&chrome=false")
		num_pages = JSON.parse(response.body)['num_pages']

		ss = Slideshow.new({url: url, slide_num: num_pages, event_id: event_id})
		ss.save!

		respond_to do |format|
			format.js
		end
	end
end
