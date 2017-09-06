class Site::HomeController < SiteController
  def index
  	@categories=Category.order_by_description
    @ads = Ad.descending_order(9)
  end
end
