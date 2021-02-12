module Public::RecordsHelper

  def studyHours( t2, t1 )
    diff = t2 - t1
    
    if diff > 3600
      h = (diff / 3600).floor
      m = ((diff - h * 3600) / 60).floor
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
      
    elsif diff > 60
      m = (diff / 60).floor
      if m < 10
        return "00:0#{m}"
      else
        return "00:#{m}"
      end
      
    else
      return "00:00"
    end
    
  end

end
