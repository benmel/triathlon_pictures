class EventController < ApplicationController
	require_dependency 'event_page_parser'

	def show
		url = params[:url]
		set_url(url)
		request_url
		if valid
			@res = links
			render :show
		else
			render :fail
		end
	end

	private
	def image_scraper
		@image_scraper ||= EventPageParser::ImageScraper.new
	end

	def set_url(url)
		image_scraper.set_url(url)
	end

	def request_url
		image_scraper.request_url
	end

	def valid
		image_scraper.valid
	end

	def links
		image_scraper.links
	end
end
