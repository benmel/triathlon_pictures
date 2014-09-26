class EventController < ApplicationController
	# TODO move this
	require 'open-uri'

	def show
		@url = params[:url]
		page = Nokogiri::HTML(open(@url))
		anchors = page.css('a.highslide')
		@res = anchors.map { |a| a['href'] }
	end

end
