class Site::HomeController < ApplicationController
	layout "site"
  def index
  	@categories=Category.order(:description)
		@ads = Ad.limit(6).order(created_at: :desc)
  end
end
