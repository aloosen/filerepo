class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :set_locale

  def set_locale
  	if params[:locale].blank?
  		redirect_to "/#{extract_locale_from_accept_language_header}"
  	else
  		I18n.locale = params[:locale]
  	end
  end

  def extract_locale_from_accept_language_header
  	browser_locale = I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'] && request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  	if browser_locale && I18n.available_locales.include?(browser_locale.to_sym)
  		browser_locale
  	else
  		I18n.default_locale
  	end
  end

  def default_url_options
  	{ locale: I18n.locale }
  end
end
