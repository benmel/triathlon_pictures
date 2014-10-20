require "rails_helper"

RSpec.describe EventPageParser do
	let(:image_scraper) { EventPageParser::ImageScraper.new }

	describe "#links" do
		it "calls backprint when host is www.backprint.com" do						
			allow(image_scraper).to receive(:open)
			allow(Nokogiri).to receive(:HTML) 
			allow(image_scraper).to receive(:host) { "www.backprint.com" }
			expect(image_scraper).to receive(:backprint)
			image_scraper.links("www.backprint.com")
		end

		it "calls backprint when host is www.backprint.com" do
		end		
	end

	describe "#valid" do
	end

	describe "#host" do
	end

	describe "#backprint" do
	end

	describe "#not_gound" do
	end
end