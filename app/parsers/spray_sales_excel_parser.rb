class SpraySalesExcelParser
  class << self
    def parse(xls)
      sales = []

      sheet = xls.sheet(0)
      japanese_year_name = sheet.cell(3, 2)

      raise ExcelParseError, "年号が取得できません" unless japanese_year_name
      raise ExcelParseError, "平成以外の年号には対応していません" unless japanese_year_name =~ /\A平成.*年度\Z/

      year = japanese_year_name.gsub(/\A平成(.*)年度\Z/, '\1').tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z').to_i + 1988

      place_name = sheet.cell(1, 2)

      raise ExcelParseError, "場所名の形式が不正です。 ('#{place_name}') (例: NNスプレー売上)" unless place_name && place_name =~ /スプレー売上\Z/

      place_name.gsub!(/\A(.*)スプレー売上\Z/, '\1')
      place = Place.find_by_alias_name(place_name)

      raise ExcelParseError, "未登録の場所です #{place_name}" unless place

      target_date = Date.new(year, 4, 1)

      start_col_idx = 3

      start_row_idx = 8

      start_row_idx.step(start_row_idx + 9, 9).with_index do |row_idx, i|
        #puts "row: #{row_idx}"
        start_col_idx.step(start_col_idx + (5 * 2), 2).with_index do |col_idx, j|
          #puts "col: #{col_idx}"
          (1..2).each do |eq_num|
            sales << parse_month(sheet, place, row_idx, col_idx, eq_num, target_date)
          end
          target_date = target_date.next_month
        end
      end

      sales
    end

    def parse_month(sheet, place, row_idx, col_idx, eq_num, target_date)
      sale = SprayMonthlySale.new  
      sale.place = place
      sale.target_month = target_date.strftime('%Y%m')
      sale.equipment_num = eq_num
      sale.prepaid_sales_amount = sheet.cell(row_idx, col_idx + eq_num - 1)
      sale.cash_sales_amount = sheet.cell(row_idx+1, col_idx + eq_num - 1)
      sale.sales_count = sheet.cell(row_idx+2, col_idx + eq_num - 1)

      #puts sale.inspect

      sale
    end
  end
end
