module EventPageParser
	class ImageScraper
		# TODO remove require
		# TODO get rid of self
		require 'uri'
		require 'open-uri'

		def links(url)
			file = open(url)
			page = Nokogiri::HTML(file)

			case host(file)
			when 'www.backprint.com'
				backprint(page)
			when 'backprint.com'
				backprint(page)
			else
				not_found
			end
		end

		def valid(url)
			true
		end

		def host(file)
			file.base_uri.host
		end

		def backprint(page)
			anchors = page.css('a.highslide')
			anchors.map { |a| a['href'] }
		end

		def not_found
			[]
		end
	end
end