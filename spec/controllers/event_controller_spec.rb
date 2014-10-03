require "rails_helper"

RSpec.describe EventController, :type => :controller do
	describe "GET #show" do
		it "returns an array for a valid url" do
			allow(controller).to receive(:valid).and_return(true)
			allow(controller).to receive(:links).and_return([])
			get :show, url: "http://www.madeupurl.com"			
			expect(response).to render_template(:show)
		end

		it "returns an error for an invalid url" do
			allow(controller).to receive(:valid).and_return(false)
			get :show, url: "http://www.secondurl.com"
			expect(response).to render_template(:fail)
		end
	end
end