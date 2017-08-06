class GuestMailer < ApplicationMailer

  def send_contact(subject, message, guest_mail)
    @subject = subject
    @message = message
    @guest_mail = guest_mail

    mail to: "imeisa002@gmail.com", subject: @subject
  end

end
