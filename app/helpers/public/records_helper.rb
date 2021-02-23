module Public::RecordsHelper

  def minute(t)
    if t >= 60
      h = (t / 60).floor
      m = t - h * 60
      if h < 10
        if m < 10
          return "0#{h}:0#{m}"
        else
          return "0#{h}:#{m}"
        end
      else
        if m < 10
          return "#{h}:0#{m}"
        else
          return "#{h}:#{m}"
        end
      end
    else
      m = t
      if m < 10
        return "00:0#{m}"
      else
        return "00:#{m}"
      end
    end
  end
  
  def yesterdayHours(user)
    yesterdayRecords = user.record.where(start.date == now.yesterday)
    sum = 0
    yesterdayRecords.each do |yesterdayRecord|
      sum += yesterdayRecord.hour
    end
    return minute(sum)
  end
  
  def sort_order(column, title)
    direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction }
    end

end
