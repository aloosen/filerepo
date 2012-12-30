require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe 'login page' do
		before do
			visit '/'
			click_link 'login'
		end
		it { should have_selector('h1', text: 'login') }
	end
	describe 'login' do
		describe 'should not work with invalid information' do
			before do
				visit '/'
				click_link 'login'
				click_button 'login'
			end
			it { should have_selector('h1', text: 'login') }
			it { should have_selector('div.alert.alert-error', text: 'Invalid') }
		end
		describe 'should work with valid information' do
			let (:user) { FactoryGirl.create(:user) }
			before do
				visit '/'
				click_link 'login'
				fill_in "session_name", with: user.name
				fill_in "Password", with: user.password
				click_button 'login'
			end
			it { should have_selector('h1', text: 'Welcome') }
		end
	end

end
