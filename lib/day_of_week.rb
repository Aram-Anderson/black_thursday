require 'time'
module DayOfWeek

  def what_day_is_it?(dates)
    dates.map do |date|
      case date
      when 0 then p "Sunday"
      when 1 then p "Monday"
      when 2 then p "Tuesday"
      when 3 then p "Wednesday"
      when 4 then p "Thursday"
      when 5 then p "Friday"
      when 6 then p "Saturday"
      end
    end
  end

end
