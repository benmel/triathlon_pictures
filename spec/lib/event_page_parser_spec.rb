require "rails_helper"

RSpec.describe EventPageParser do
	let(:image_scraper) { EventPageParser::ImageScraper.new }

	describe "#links" do
		before :each do
			allow(Nokogiri).to receive(:HTML)
		end

		context "backprint" do			
			it "calls backprint when host is www.backprint.com" do
				allow(image_scraper).to receive(:host) { "www.backprint.com" }
				expect(image_scraper).to receive(:backprint)
				image_scraper.links
			end
			it "calls backprint when host is www.backprint.com" do
				allow(image_scraper).to receive(:host) { "backprint.com" }
				expect(image_scraper).to receive(:backprint)
				image_scraper.links
			end	
		end

		context "not_found" do
			it "calls not_found when host isn't matched" do
				allow(image_scraper).to receive(:host) { "www.example.com"}
				expect(image_scraper).to receive(:not_found)
				image_scraper.links
			end
		end	
	end

	describe "#set_url" do
		it "creates an Addressable::URI" do
			expect(image_scraper.set_url("www.example.com")).to be_a(
				Addressable::URI)
		end	
	end

	describe "#request_url" do
		it "returns a file for a valid url" do
			image_scraper.set_url("http://example.com")
			expect(OpenURI).to receive(:open_uri)
			image_scraper.request_url
		end
		it "returns nil for a scheme that is not http or https" do
			image_scraper.set_url("ftp://example.com")
			expect(image_scraper.request_url).to be_nil
			image_scraper.set_url("htttp://example.com")
			expect(image_scraper.request_url).to be_nil
		end	
		context "errors" do
			before :each do
				image_scraper.set_url("http://example.com")
			end
			after :each do
				expect(image_scraper.request_url).to be_nil
			end
			it "returns nil for OpenURI::HTTPError" do
				exception_io = double("io")
				allow(exception_io).to receive_message_chain(:status,:[]).with(0) { "302" }
				allow(OpenURI).to receive(:open_uri).and_raise(
					OpenURI::HTTPError.new('',exception_io))
			end
			it "returns nil for a SocketError" do
				allow(OpenURI).to receive(:open_uri).and_raise(SocketError)
			end
			it "returns nil for Errno::ENOENT" do
				allow(OpenURI).to receive(:open_uri).and_raise(Errno::ENOENT)
			end
			it "returns nil for Errno::ETIMEDOUT" do
				allow(OpenURI).to receive(:open_uri).and_raise(Errno::ETIMEDOUT)
			end
		end
	end

	describe "#valid" do
		# should return true if file is not nil
	end

	describe "#host" do
		# should return the host name of a file
	end

	describe "#backprint" do
		it "returns an array" do
			doc = Nokogiri::HTML(open(Rails.root + 'spec/fixtures/backprint.html'))
			expect(image_scraper.backprint(doc)).to be_a(Array)
		end
	end

	describe "#not_found" do
		it "returns an empty array" do
			expect(image_scraper.not_found).to eq([])
		end
	end
end