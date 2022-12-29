require 'open-uri'
require 'sinatra'

set :views, settings.root

get '/' do
	markdown :README
end

get '/feed' do
	url = 'https://xkcd.com/rss.xml'
	match = /(&lt;img.*? alt="(?<alt>.*?)".*?&gt;)/
	replace = "\n\\0\n&lt;p&gt;alt-text: \\k<alt>&lt;/p&gt;\n"
	feed = URI.parse(url).open do |page|
		page.read.sub(/xkcd.com/, 'xkcd.com - with alt-text')
	end
	feed.gsub(match, replace)
end
