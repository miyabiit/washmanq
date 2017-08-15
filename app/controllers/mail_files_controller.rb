class MailFilesController < ApplicationController
  def download
    @mail_file = MailFile.find(params[:id])
    if @mail_file.file.respond_to?(:expiring_url)
      redirect_to @mail_file.file.expiring_url(1.minutes)
    else
      redirect_to @mail_file.file.url
    end
  end
end
