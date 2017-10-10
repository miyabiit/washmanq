class CamerasController < ApplicationController
  def index
    @cameras = Camera.all
  end

  def show
    @camera = Camera.find(params[:id])

    param_from = params[:from] || flash[:from]
    param_to = params[:to] || flash[:to]

    @from = (Time.zone.strptime(param_from, '%Y-%m-%d %H:%M') if param_from.present?) rescue nil
    @to = (Time.zone.strptime(param_to, '%Y-%m-%d %H:%M') if param_to.present?) rescue nil
  end
end
