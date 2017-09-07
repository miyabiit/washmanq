class FaxMailer < ApplicationMailer
  def receive(email)
    logger.debug "RECEIVE MAIL ========="
    logger.debug "FROM: #{email.from.first}"
    logger.debug "TO: #{email.to.first}"
    logger.debug "SUBJECT: #{email.subject}"
    logger.debug "DATE: #{email.date}"
    if email.multipart?
      logger.debug "TEXT: #{email.text_part&.decoded}"
      logger.debug "HTML: #{email.html_part&.decoded}"
      if email.attachments.present?
        email.attachments.each do |attachment|
          logger.debug "FILE: #{attachment.filename}"
        end
      end
    else
      logger.debug "BODY: #{email.body&.decoded}"
    end
    logger.debug "======================"

    ApplicationRecord.transaction do
      mail_info = MailInfo.create!(
        title: email.subject,
        from: email.from.first,
        content: (email.multipart? ? (email.html_part&.decoded.presence || email.text_part&.decoded.presence || '') : email.body&.decoded),
        received_at: email.date
      )
      email.attachments.each do |attachment|
        file = StringIO.new(attachment.decoded)
        file.class.class_eval { attr_accessor :original_filename, :content_type }
        file.original_filename = attachment.filename
        file.content_type = attachment.mime_type

        mail_info.mail_files << MailFile.new(file: file)
      end
    end
  end
end
