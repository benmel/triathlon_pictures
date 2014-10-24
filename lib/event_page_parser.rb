module EventPageParser
	class ImageScraper
		# TODO remove require
		require 'uri'
		require 'open-uri'
		require 'addressable/uri'

		def links
			page = Nokogiri::HTML(@file)
			case host
			when 'www.backprint.com'
				backprint(page)
			when 'backprint.com'
				backprint(page)
			else
				not_found
			end
		end

		def set_url(url)
			@url = Addressable::URI.heuristic_parse(url)
		end

		def request_url
			if %w(http https).include?(@url.scheme)
				@file = begin
					open(@url.to_s)
				rescue OpenURI::HTTPError => he
					puts he
					nil
				rescue SocketError => se	
					puts se
					nil
				rescue Errno::ENOENT => en
					puts en
					nil
				rescue Errno::ETIMEDOUT => et
					puts et
					nil	
				end
			else
				@file = nil
			end	
		end

		def valid
			!@file.nil? 
		end

		def host
			@file.base_uri.host
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