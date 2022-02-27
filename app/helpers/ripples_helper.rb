module RipplesHelper
  RIPPLES_MAX = 10

  def index_offset(ripple_offset)
    @ripples = Ripple.all.order("id DESC").offset(@ripple_offset).limit(RIPPLES_MAX)
  end

  def set_page_number(page_number)
    session[:page_number] = page_number
  end

  def get_page_number
    return session[:page_number]
  end

  def set_ripple_offset(offset)
    @ripple_offset = offset
  end

  def get_ripple_offset
    return @ripple_offset
  end

  def get_ripples
    return @ripples
  end

  def reset_session
    session.clear
  end

  # set the newest/maximum ripple id
  def maximum_ripple_id
    @maximum_ripple_id = Ripple.last.id
  end

  # set the highest page number value
  def maximum_page_number
    if maximum_ripple_id % 10
      maximum_page_number = (maximum_ripple_id / 10).ceil
    else
      maximum_page_number = (maximum_ripple_id/ 10) - 1
    end
  end

  # reset page
  def reset_pages
    page_number = 0
    self.set_page_number(page_number)
  end

  # moves to the page with the newest ripples (max 10)
  def newest
    page_number = 0
    self.set_page_number(page_number)
    self.index_offset(maximum_ripple_id)
    render :index
  end

  # moves to the page with the previous 10 newer ripples (max 10)
  def previous
    page_number = get_page_number

    if page_number > 0
      previous_page = page_number - 1
      self.set_page_number(previous_page)
      offset = previous_page * RIPPLES_MAX
      self.set_ripple_offset(offset)
    elsif page_number <= 0
      page_number = 0
      self.set_page_number(page_number)
      offset = @maximum_ripple_id
      self.set_ripple_offset(offset)
    end
    self.index_offset(@ripple_offset)
    render :index
  end

  # moves to the page with the next 10 older ripples (max 10)
  def next
    page_number = get_page_number

    if page_number < maximum_page_number
      next_page = page_number + 1
      self.set_page_number(next_page)
      offset = next_page * RIPPLES_MAX
      self.set_ripple_offset(offset)
    elsif page_number >= maximum_page_number
      self.set_page_number(maximum_page_number)
      offset = maximum_page_number * RIPPLES_MAX
      self.set_ripple_offset(offset)
    end
    self.index_offset(@ripple_offset)
    render :index
  end

  # moves to the page with the oldest ripples (max 10)
  def oldest
    page_number = maximum_page_number
    self.set_page_number(maximum_page_number)
    offset = maximum_page_number * RIPPLES_MAX
    self.set_ripple_offset(offset)
    self.index_offset(@ripple_offset)
    render :index
  end

  # handles the newest link enable/disable on index
  def newest_link(string,url)
    if get_page_number == 0
      return string
    else
      return link_to string, url
    end
  end

  # handles the previous link enable/disable on index
  def previous_link(string,url)
    if get_page_number == 0
      return string
    else
      return link_to string, url
    end
  end

  # handles the next link enable/disable on index
  def next_link(string,url)
    if get_page_number == maximum_page_number
      return string
    else
      return link_to string, url
    end
  end

  # handles the oldest link enable/disable on index
  def oldest_link(string,url)
    if get_page_number == maximum_page_number
      return string
    else
      return link_to string, url
    end
  end
end
