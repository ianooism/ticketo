class CommentMailer < ApplicationMailer
  def after_create(comment)
    recipients = comment.ticket.watchers - [comment.owner]
    subject = "Comment created by #{comment.owner.email}"
    
    recipients.each do |recipient|
      mail to: recipient.email, subject: subject
    end
  end
end
