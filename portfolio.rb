# portfolio.rb
require 'sinatra'

get '/' do
  erb :"index.html"
end

get '/:name' do
  erb :"name.html", :locals => {:name => params['name']}
end

helpers do
  def social_media
    [{  :name => 'twitter',
        :url => 'https://www.twitter.com/beardedstudio' },
      { :name => 'github',
        :url => 'https://www.github.com/brett-bender'}
      ]
  end
end
