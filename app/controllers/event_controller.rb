class EventController < ApplicationController
	require_dependency 'event_page_parser'
	def show
		url = params[:url]
		@res = EventPageParser::ImageScraper.links(url)
	end
end
