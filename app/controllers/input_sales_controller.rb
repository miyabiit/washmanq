class InputSalesController < ApplicationController
  def index
    today = Date.today
    @year = today.year
    @month = today.month
    @year_month = "%04d%02d" % [@year, @month] 
    @target_date = today.beginning_of_month
    @place = Place.first
    render 'sales/edit'
  end
end
