module RipplesHelper
  # handles the newest link enable/disable on index
  def newest_link(string,url)
    if session[:page_number] == 0
      return string
    else
      return link_to string, url
    end
  end

  # handles the previous link enable/disable on index
  def previous_link(string,url)
    if session[:page_number] == 0
      return string
    else
      return link_to string, url
    end
  end

  # handles the next link enable/disable on index
  def next_link(string,url)
    if session[:page_number] == maximum_page_number
      return string
    else
      return link_to string, url
    end
  end

  # handles the oldest link enable/disable on index
  def oldest_link(string,url)
    if session[:page_number] == maximum_page_number
      return string
    else
      return link_to string, url
    end
  end
end
