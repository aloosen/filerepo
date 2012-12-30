require 'spec_helper'

describe "Static Pages" do
	describe "Home Page" do
		it "should have in the content 'Welcome'" do
			visit '/'
			page.should have_content('Welcome')
		end

		it "should redirect to home page in German" do
			page.driver.header 'Accept-Language', 'de'
			visit '/'
			current_path.should eq('/de')
			page.should have_content('Anmelden')
		end
	end
end
