class CustomersController < ApplicationController

def new
	@customer = Customer.new
end

def create
	@customer = Customer.new(params[:customer])
	if @customer.save
		redirect_to controller: 'users', action: 'refresh'
	end
end

def edit
	@customer = Customer.find(params[:id])
end

def update
	@customer = Customer.find(params[:id])
	if @customer.update_attributes(params[:customer])
		redirect_to controller: 'users', action: 'refresh'
	end
end

end
