class SalesController < ApplicationController
  before_action :setup_year_month

  def index
    @summaries, @all_summary = SalesCalculator.summary_with_rate(@target_date)
  end

  def place
    @place = Place.find(params[:place_id])
    @wash_sales_by_month = SalesCalculator.summary_by_equipment(WashSale.where(place: @place, target_date: @date_range))
    @spray_sales = SpraySale.where(place: @place, target_month: @year_month)
  end

  def transition
    @place = if params[:place_id].present? && params[:place_id].to_i != 0
               Place.find(params[:place_id])
             end
    @summaries = if @place
                   SalesCalculator.summary_with_rate_for_transition(@place, Date.today)
                 else
                   SalesCalculator.all_summary_with_rate_for_transition(Date.today)
                 end
  end

  private

  def setup_year_month
    today = Date.today
    @year = params[:year].presence&.to_i || today.year
    @month = params[:month].presence&.to_i || today.month
    @year_month = "%04d%02d" % [@year, @month] 
    @target_date = Date.strptime(@year_month, '%Y%m')
    @date_range = (@target_date.beginning_of_day .. @target_date.end_of_month.end_of_day)
  end
end
