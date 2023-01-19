require 'net/http'
require "cgi"

def getHTML(url) 
    uri = URI(url)
    source = Net::HTTP.get(uri)
end
source = getHTML('https://www.nasa.gov/press-release/nasa-industry-to-collaborate-on-space-communications-by-2025/')
link=""
if source.include? "window.forcedRoute = "
    link = source[source.index("window.forcedRoute = ")+"window.forcedRoute = ".length,source.size-1]
    if link.include? "</script>"
        link = link[0, link.index("</script>")]
        link.gsub! '"', ''
    end
    link = "https://www.nasa.gov/api/2"+link
end
response = getHTML(link)
title = ""
date=""
release_no=""
article =""

if response.include? "\"title\":\""
    title = response[response.index("\"title\":\"")+"\"title\":\"".length,response.size-1] 
    if title.include? "\""
        title = title[0, title.index("\"")]
    end
end
if response.include? "\"promo-date-time\":\""
    date = response[response.index("\"promo-date-time\":\"")+"\"promo-date-time\":\"".length,response.size-1] 
    if date.include? "\""
        date = date[0, date.index("\"")]
    end
end
if response.include? "\"release-id\":\""
    release_no = response[response.index("\"release-id\":\"")+"\"release-id\":\"".length,response.size-1] 
    if release_no.include? "\""
        release_no = release_no[0, release_no.index("\"")]
    end
end
if response.include? "Credits:"
    article = response[response.index("Credits:")+"Credits:".length,response.size-1] 
    if article.include? "<p>"
        article = article[article.index("<p>")+"<p>".length,response.size-1] 
    end
    if article.include? "-end-</p>"
        article = article[0, article.index("-end-</p>")]
    end
    
    while article.include? "<" and article.include? ">"
        text = article[article.index("<")..article.index(">")] 
        article.slice! text
    end
 
end
article = CGI::unescapeHTML(article)
article.gsub! '\n', ''
puts article
webpage = {
    :title => title,
    :date => date,
    :release_no => release_no,
    :article => article
}


