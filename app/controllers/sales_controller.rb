class SalesController < ApplicationController
  def index
    @year_month = Date.today.strftime('%Y%m')
    if params[:year].present? && params[:month].present?
      @year_month = "%04d%02d" % [params[:year].to_i, params[:month].to_i] 
    end
    @summaries = SalesSummary.where(target_month: @year_month)
  end
end
