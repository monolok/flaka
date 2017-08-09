class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :post_count, :new_subscriber, :subscriber_all

  def post_count
  	@post_count = Post.all.count
  end

  def new_subscriber
  	@subscriber = Subscriber.new
  end

  def subscriber_all
  	@subscribers = Subscriber.all
  end

end
