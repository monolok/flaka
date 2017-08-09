class GuestMailer < ApplicationMailer

  def send_contact(subject, message, guest_mail)
    @subject = subject
    @message = message
    @guest_mail = guest_mail

    mail to: "imeisablog@gmail.com", subject: @subject
  end

  def send_subscriber(post_title, post_body, post_categories, post_created_at, subscribers)
  	@post_title = post_title
  	@post_body = post_body
  	@post_categories = post_categories
  	@post_created_at = post_created_at

  	# @subscribers = subscribers
  	mail(
      bcc: subscribers.map(&:email).uniq, 
      subject: "multiple mails"
    )
  end

end
