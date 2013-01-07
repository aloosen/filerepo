class UsersController < ApplicationController
	def index
		create_userlist
	end

	def new
		@user = User.new
		@customers = Customer.all
		@roles = Role.all
	end

	def create
		@user = User.new(params[:user])
		if @user.save
		  create_userlist
		end
	end

	def destroy
		User.find(params[:id]).destroy
		create_userlist
	end

	def edit
		@user = User.find(params[:id])
		@customers = Customer.all
		@roles = Role.all
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(params[:user])
		create_userlist
	end

	def create_userlist
		@customer_users=Hash.new
		Customer.all.each do |c|
			@customer_users[c] = User.where( :customer_id => c.id)
		end
		@customers = Customer.all
		@roles = Role.all
	end

	def refresh
		@customer_users=Hash.new
		Customer.all.each do |c|
			@customer_users[c.name] = User.where( :customer_id => c.id)
		end
		@customers = Customer.all
		@roles = Role.all
	end
end
