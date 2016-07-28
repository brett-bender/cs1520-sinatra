# portfolio.rb
require 'sinatra'
require 'pony'

get '/' do
  erb :"index.html"
end

post '/contact' do
  locals = {}

  locals[:name] = params['name']
  locals[:email] = params['email']
  locals[:message] = params['message']
  locals[:subject] = params['subject']

  unless params.key?('honeypot') && params['honeypot'].nil?
    message_body = erb(:"_email-body.html", :locals => locals)

    email = Pony.mail :to => 'test@example.com',
                      :from => 'noreply@example.com',
                      :subject => "contact email from your website!",
                      :body => message_body
    puts email
  end

  redirect '/'
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
