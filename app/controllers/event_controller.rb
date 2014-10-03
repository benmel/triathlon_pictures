class EventController < ApplicationController
	require_dependency 'event_page_parser'

	def show
		@url = params[:url]
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

	def valid
		image_scraper.valid(@url)
	end

	def links
		image_scraper.links(@url)
	end
end
