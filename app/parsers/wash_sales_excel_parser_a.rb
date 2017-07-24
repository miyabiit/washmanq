class WashSalesExcelParserA
  class << self
    def parse(xls)
      # TODO: 今月と前月のどちらを読み取るか決める
      #   -> 一旦入力画面に戻してユーザー選択にする？
      
      sales = []

      this_month_sheet = xls.sheet('売上報告書（今月）')
      this_month = this_month_sheet.cell(8, 2).to_i
      if this_month == 0
        raise ExcelParseError, "今月の月が取得できません"
      end

      prev_year = xls.sheet('売上報告書（前年）').cell(8, 2).to_i
      if prev_year == 0
        raise ExcelParseError, "年が取得できません"
      end
      this_year = prev_year + 1
      this_target_date = Date.new(this_year, this_month, 1)
      
      target_date = this_target_date.prev_month.to_date
      sheet = xls.sheet('売上報告書（前月）')
      place_name = sheet.cell(3, 6)
      place = Place.find_by_alias_name(place_name)
      raise ExcelParseError, "未登録の場所です #{place_name}" unless place
      start_row_idx = 12  
      equipment_count = place.equipment_count
      last_day = target_date.end_of_month.day

      (1..equipment_count).each do |eq_num|
        (start_row_idx .. (start_row_idx + last_day - 1)).each do |row_idx|
          sales << parse_row(sheet, row_idx, eq_num, place, target_date)
          target_date += 1
        end
      end

      sales
    end

    def parse_row(sheet, row_idx, equipment_num, place, target_date)
      sale = WashSale.new
      sale.place = place
      sale.target_date = target_date
      sale.equipment_num = equipment_num

      base_col_idx = 6 + (equipment_num - 1) * 13 

      # read courses
      (base_col_idx .. (base_col_idx + 7)).each_with_index do |col_idx, i|
        course_sales_count = sheet.cell(row_idx, col_idx)
        sale.wash_sale_courses << WashSaleCourse.new(course: Course.find(i+1), sales_count: course_sales_count.to_i)
      end
      sale.sales_count = get_value(sheet, row_idx, base_col_idx + 8, "台数")
      sales_amount = get_value(sheet, row_idx, base_col_idx + 9, '売り上げ')
      prepaid_sales_point = get_value(sheet, row_idx, base_col_idx + 10, 'プリペイド点数')
      prepaid_sales_amount = get_value(sheet, row_idx, base_col_idx + 11, 'プリペイド売り上げ')

      sale.cash_sales_amount = sales_amount - prepaid_sales_amount
      sale.prepaid_sales_point = prepaid_sales_point
      sale.prepaid_sales_amount = prepaid_sales_amount

      #puts sale.inspect

      sale
    end

    def get_value(sheet, row, col, val_name)
      value = sheet.cell(row, col)
      raise ExcelParseError, "#{val_name}が取得できません: (#{row}, #{col})" unless value
      value
    end
  end
end
