require "rubygems"
require "bundler/setup"

require 'sinatra'
require 'xml'

doc = XML::Document.file('Links.xml')
links = []
doc.find('//links/link').each do |g|
  links << g.attributes.inject({}) { |h, a| h[a.name] = a.value; h }
end

links.each do |l|
  get '/' + l['id'] do
    redirect l['url'], 302
  end
end

get '/?' do
  erb :home
end
