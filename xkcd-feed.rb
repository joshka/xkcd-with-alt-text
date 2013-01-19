require 'open-uri'
require 'sinatra'

get '/feed' do
	url = 'http://xkcd.com/rss.xml'
	match = /(&lt;img.*? alt="(?<alt>.*?)".*?&gt;)/
	replace = "\n\\0\n&lt;p&gt;alt-text: \\k<alt>&lt;/p&gt;\n"
	open(url) do |page|
		feed = page.read.sub(/xkcd.com/, 'xkcd.com - with alt-text')
		feed.gsub(match, replace)
	end
end