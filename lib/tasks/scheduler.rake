desc "Sending mails to subscribers"
task mail_to_subscribers: :environment do
	
	@last_post = Post.last

	if not @last_post.was_sent
		@post_title = @last_post.title
		@post_body = @last_post.body
		@post_categories = @last_post.categories
		@post_created_at = @last_post.created_at.strftime('%b %d, %Y')
		@subscribers = Subscriber.all
		GuestMailer.send_subscriber(@post_title, @post_body, @post_categories, @post_created_at, @subscribers).deliver_now
		@last_post.update(was_sent: true)
	else
		puts "no new posts to send to subscribers"
	end
end

