class ExcelParser
  class << self
    def parse(file)
      xls = case file.original_filename
            when /\.xls$/
              Roo::Excel.new(file) # file.read?
            when /\.xlsx$/
              Roo::Excelx.new(file) # file.read?
            end
      xls_sheet = xls.sheet('月計')
      case xls.sheets(0)
      when '売上報告書（今月）'
        # wash sales pattern A
        WashSalesExcelParserA.parse(xls)
      when '月計'
        # wash sales pattern B
        WashSalesExcelParserB.parse(xls)
      when /年度$/
        # spray sales
        SpraySalesExcelParser.parse(xls)
      else
        raise 'エクセルファイルの判定に失敗しました'
      end
    end
  end 
end
