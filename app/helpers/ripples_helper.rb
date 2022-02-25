module RipplesHelper
  def previous_link(string,url)
    if session[:max_ripple_id] == Ripple.maximum("id")
      puts "bob1111111111111"
      return string
    else
      puts "bob2222222222222"
      return link_to string, url
    end
  end

  def next_link(string,url)
    if session[:min_ripple_id] == 1
      puts "bob3333333333333"
      return string
    else
      puts "bob4444444444444"
      return link_to string, url
    end
  end
end
