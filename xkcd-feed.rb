require 'open-uri'
require 'sinatra'
require 'kramdown'

get '/' do
	readme = File.read('README.md')
	Kramdown::Document.new(readme).to_html
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
