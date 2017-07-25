class SalesFilesController < ApplicationController
  def index
    @sales_file = SalesFile.new
    @sales_files = SalesFile.all.order(created_at: :desc).page(params[:page])
  end

  def create
    objs = ExcelParser.parse(params[:sales_file][:excel])
    SalesFile.transaction do 
      @sales_file = SalesFile.create!(sales_file_params)
      objs.each do |o|
        o.destroy_duplication
        o.save!
      end
    end
    render status: :ok, json: @sales_file
  rescue ExcelParseError => ex
    render status: :unprocessable_entity, json: {error: {messages: [ex.message]}}
  end

  private

  def sales_file_params
    params.require(:sales_file).permit(:excel)
  end
end
