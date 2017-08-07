module ApplicationHelper

  def format_percentage(rate, precision: 1)
    if rate
      (rate * 100).to_s(:percentage, precision: precision) if rate
    else
      ' - '
    end
  end
end
