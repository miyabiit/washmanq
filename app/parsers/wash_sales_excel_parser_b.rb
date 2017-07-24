class WashSalesExcelParserB
  class << self
    def parse(xls)
      sales = []

      sheet = xls.sheet('月計')
      equipment_num, place_name = sheet.cell(3, 1).split('：')

      raise ExcelParseError, "機種番号が取得できません" unless equipment_num
      raise ExcelParseError, "場所が取得できません" unless place_name

      place = Place.find_by_alias_name(place_name)

      raise ExcelParseError, "未登録の場所です #{place_name}" unless place

      start_row_idx = 7
      target_date = format_excel_date(sheet.cell(start_row_idx, 1))
      last_day = target_date.end_of_month.day
      start_row_idx.step(start_row_idx+(4*(last_day-1)), 4) do |row_idx|
        sales << parse_row(sheet, row_idx, equipment_num, place, target_date)
        target_date += 1
      end

      sales
    end

    def parse_row(sheet, row_idx, equipment_num, place, target_date)
      sale = WashSale.new
      sale.place = place
      sale.target_date = target_date
      sale.equipment_num = equipment_num
      base_col_idx = 8

      # read courses
      base_col_idx.step(base_col_idx+5*8, 5).with_index do |col_idx, i|
        course_sales_count = sheet.cell(row_idx, col_idx)
        cash_sales_amount = sheet.cell(row_idx+1, col_idx)
        prepaid_sales_amount = sheet.cell(row_idx+2, col_idx)
        sale.wash_sale_courses << WashSaleCourse.new(course: Course.find(i+1), sales_count: course_sales_count.to_i, cash_sales_amount: cash_sales_amount, prepaid_sales_amount: prepaid_sales_amount)
      end

      sum_base_col_idx = 130
      sale.sales_count = get_value(sheet, row_idx, sum_base_col_idx, "台数")
      sale.cash_sales_amount = get_value(sheet, row_idx+1, sum_base_col_idx, '現金売上')
      sale.prepaid_sales_amount = get_value(sheet, row_idx+2, sum_base_col_idx, 'プリペイド売上')

      puts sale.inspect

      sale
    end

    def get_value(sheet, row, col, val_name)
      value = sheet.cell(row, col)
      raise ExcelParseError, "#{val_name}が取得できません: (#{row}, #{col})" unless value
      value
    end

    def format_excel_date(xl_date_num)
      base_date = Date.new(1899, 12, 30)
      base_date + xl_date_num.to_i
    end
  end
end
