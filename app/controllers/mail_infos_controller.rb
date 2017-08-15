class MailInfosController < ApplicationController
  def index
    @mail_infos = MailInfo.all.order(created_at: :desc).page(params[:page])
  end
end
