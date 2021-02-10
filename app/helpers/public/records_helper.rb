module Public::RecordsHelper

  def studyHours( t2, t1 )
    diff = t2 - t1
    if diff > 3600
      h = (diff / 3600).floor
      m = ((diff - h * 3600) / 60).floor
      "#{h}:#{m}"
    elsif diff > 60
      m = (diff / 60).floor
      "#00:#{m}"
    end
  end

end
