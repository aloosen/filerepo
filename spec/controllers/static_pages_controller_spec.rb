require 'spec_helper'

describe "Static Pages" do
	describe "Home Page" do
		it "should have in the content 'Welcome'" do
			visit '/'
			page.should have_content('Welcome')
		end
		it "should redirect to home page in German" do
			request.env['HTTP_ACCEPT_LANGUAGE'] = 'de'
			visit '/'
			response.should redirect_to('/de')
		end
	end
end
