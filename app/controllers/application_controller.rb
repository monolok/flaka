class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :post_count

  def post_count
  	@post_count = Post.all.count
  end

end
