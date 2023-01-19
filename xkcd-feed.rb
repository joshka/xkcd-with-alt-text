require 'open-uri'
require 'sinatra'

set :views, settings.root

get '/' do
	markdown :README
end

# This is a simple proxy for the xkcd RSS feed, which adds the alt-text
# to the description of each comic.
get '/feed' do
	url = 'https://xkcd.com/rss.xml'
	match = /(&lt;img.*? alt="(?<alt>.*?)".*?&gt;)/
	replace = "\n\\0\n&lt;p&gt;alt-text: \\k<alt>&lt;/p&gt;\n"

	feed = URI.open(url, "Accept" => request.env["Accept"]) do |page|
		content_type page.content_type
		page.read.sub(/xkcd.com/, 'xkcd.com - with alt-text')
	end
	feed.gsub(match, replace)
end
