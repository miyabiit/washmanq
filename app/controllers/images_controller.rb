class ImagesController < ApplicationController
  def index
    @camera = Camera.find(params[:camera_id])
    from = (Time.zone.strptime(params[:from], '%Y-%m-%d %H:%M') if params[:from].present?) rescue nil
    to = (Time.zone.strptime(params[:to], '%Y-%m-%d %H:%M') if params[:to].present?) rescue nil

    from ||= Time.new(1999, 1, 1)
    to ||= Time.zone.now

    limit = 20
    @images = @camera.camera_images.where(shooted_at: from .. to).order(shooted_at: :desc).limit(limit)
    if params[:page].present?
      @images = @images.offset(limit * params[:page].to_i)
    end
  end
end
