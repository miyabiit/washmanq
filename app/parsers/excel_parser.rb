class ExcelParser
  class << self
    def parse(file)
      xls = case file.original_filename
            when /\.xlsx$/
              Roo::Excelx.new(file.tempfile.path) # file.read?
            end
      raise ExcelParseError, "#{File.extname(file.original_filename)[1..-1]}ファイルには対応していません。xlsxファイルをアップロードしてください" unless xls
      case xls.sheets.first
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
        raise ExcelParseError, 'エクセルファイル種類の判定に失敗しました'
      end
    end
  end 
end
