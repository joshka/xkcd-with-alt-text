require 'open-uri'
require 'sinatra'

get '/' do
	url = 'http://xkcd.com/rss.xml'
	match = /(&lt;img.*? alt="(?<alt>.*?)".*?&gt;)/
	replace = "\n\\0\n&lt;p&gt;alt-text: \\k<alt>&lt;/p&gt;\n"
	open(url) do |page|
		page.read.gsub(match, replace)
	end
end