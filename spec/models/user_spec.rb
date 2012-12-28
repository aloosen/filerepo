require 'spec_helper'

describe User do
	before { @user = User.new( fullname: 'Andreas Loosen', name: 'aloosen', email: 'andreas@loosen.it', password: '2Wbg12' ) }

	subject { @user }

	it { should respond_to( :name ) }
	it { should respond_to( :fullname ) }
	it { should respond_to( :email ) }
	it { should respond_to( :password_digest ) }
	it { should respond_to( :password ) }
	it { should be_valid }

	describe "when name is missing" do
		before  { @user.name = "" }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before  { @user.name = "x" * 17 }
		it { should_not be_valid }
	end

	describe "when fullname is missing" do
		before  { @user.fullname = "" }
		it { should_not be_valid }
	end

	describe "when password is too short" do
		before  { @user.password = 'x' * 5 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be invalid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	describe "when user is already taken" do
		before do
			user_with_same_name = @user.dup
			user_with_same_name.save
		end
		it { should_not be_valid }
	end

	describe "return value of authentication" do
		before { @user.save }
		let( :found_user ) { User.find_by_name( @user.name) }

		describe "with valid password" do
			it { should == found_user.authenticate( @user.password ) }
		end

		describe "with invalid password" do
			let( :user_for_invalid_password) { found_user.authenticate("invalid") }
			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end
end
