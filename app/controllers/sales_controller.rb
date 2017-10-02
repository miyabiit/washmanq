class SalesController < ApplicationController
  before_action :setup_year_month
  before_action :setup_place_sales, only: [:place, :edit]

  def index
    @summaries, @all_summary = SalesCalculator.summary_with_rate(@target_date)
  end

  def place
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

  def edit
  end

  def update
    ApplicationRecord.transaction do
      @place = Place.find(params[:place_id])
      params[:wash_sales].each do |sales_param|
        monthly_sale = WashMonthlySale.find_or_initialize_by(target_month: @year_month, place: @place, equipment_num: sales_param[:equipment_num])
        monthly_sale.sales_count = sales_param[:sales_count]
        monthly_sale.cash_sales_amount = sales_param[:cash_sales_amount]
        monthly_sale.prepaid_sales_amount = sales_param[:prepaid_sales_amount]
        monthly_sale.operated_by = :user
        monthly_sale.save!
      end
      WashMonthlySale.where(target_month: @year_month, place: @place).where.not(
        equipment_num: params[:wash_sales].map{|s| s[:equipment_num] }
      ).destroy_all

      params[:spray_sales].each do |sales_param|
        monthly_sale = SprayMonthlySale.find_or_initialize_by(target_month: @year_month, place: @place, equipment_num: sales_param[:equipment_num])
        monthly_sale.sales_count = sales_param[:sales_count]
        monthly_sale.cash_sales_amount = sales_param[:cash_sales_amount]
        monthly_sale.prepaid_sales_amount = sales_param[:prepaid_sales_amount]
        monthly_sale.operated_by = :user
        monthly_sale.save!
      end
      SprayMonthlySale.where(target_month: @year_month, place: @place).where.not(
        equipment_num: params[:spray_sales].map{|s| s[:equipment_num] }
      ).destroy_all

      SalesSummaryCreator.create_or_update(@place, @year_month, skip_monthly_sales_creation: true)
    end

    render json: {}, status: :ok
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

  def setup_place_sales
    @place = Place.find(params[:place_id])
    @wash_sales = WashMonthlySale.where(place: @place, target_month: @year_month).order(equipment_num: :asc)
    @spray_sales = SprayMonthlySale.where(place: @place, target_month: @year_month).order(equipment_num: :asc)
  end
end
