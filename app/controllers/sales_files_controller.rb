class SalesFilesController < ApplicationController
  def index
    @sales_file = SalesFile.new
  end

  def create
    SalesFile.create!(sales_file_params)
  end

  private

  def sales_file_params
    params.require(:sales_file).permit(:excel)
  end
end
