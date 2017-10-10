class ImagesController < ApplicationController
  include ActionController::Streaming
  include Zipline

  before_action :setup_params

  def index
    limit = 20
    @images = @camera.camera_images.where(shooted_at: @from .. @to).order(shooted_at: :desc).limit(limit)
    if params[:page].present?
      @images = @images.offset(limit * params[:page].to_i)
    end
  end

  def download
    @images = @camera.camera_images.where(shooted_at: @from .. @to)
    limit = 200
    if @images.count > limit
      flash[:alert] = "#{limit}件を超える画像はダウンロードできません"
      flash[:from] = @from.strftime('%Y-%m-%d %H:%M')
      flash[:to] = @to.strftime('%Y-%m-%d %H:%M')
      redirect_to camera_path(id: @camera)
      return
    elsif @images.count == 0
      flash[:alert] = "画像がありません"
      flash[:from] = @from.strftime('%Y-%m-%d %H:%M')
      flash[:to] = @to.strftime('%Y-%m-%d %H:%M')
      redirect_to camera_path(id: @camera)
      return
    end

    files = @images.lazy.map{|image| [
      image.image.url =~ /\Ahttp/ ? open(image.image.url) : open("http://#{request.host_with_port}#{image.image.url}"),
      "#{@camera.name}/#{image.image.original_filename}"
    ]}
    zipline(files, "#{@camera.name}-#{@from&.strftime('%Y%m%d%H%M')}-#{@to&.strftime('%Y%m%d%H%M')}.zip")
  end

  private

  def setup_params
    @camera = Camera.find(params[:camera_id])
    @from = (Time.zone.strptime(params[:from], '%Y-%m-%d %H:%M') if params[:from].present?) rescue nil
    @to = (Time.zone.strptime(params[:to], '%Y-%m-%d %H:%M') if params[:to].present?) rescue nil
    @from ||= Time.new(1999, 1, 1)
    @to ||= Time.zone.now
  end
end
