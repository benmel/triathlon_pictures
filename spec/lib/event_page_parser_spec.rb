require "rails_helper"

RSpec.describe EventPageParser do
	let(:image_scraper) { EventPageParser::ImageScraper.new }

	describe "#links" do
		before :each do
			allow(image_scraper).to receive(:open)
			allow(Nokogiri).to receive(:HTML)
		end

		context "backprint" do			
			it "calls backprint when host is www.backprint.com" do
				allow(image_scraper).to receive(:host) { "www.backprint.com" }
				expect(image_scraper).to receive(:backprint)
				image_scraper.links("www.backprint.com")
			end
			it "calls backprint when host is www.backprint.com" do
				allow(image_scraper).to receive(:host) { "backprint.com" }
				expect(image_scraper).to receive(:backprint)
				image_scraper.links("backprint.com")
			end	
		end

		context "not_found" do
			it "calls not_found when host isn't matched" do
				allow(image_scraper).to receive(:host)
				expect(image_scraper).to receive(:not_found)
				image_scraper.links("www.example.com")
			end
		end	
	end

	describe "#valid" do
	end

	describe "#host" do
	end

	describe "#backprint" do
	end

	describe "#not_found" do
	end
end