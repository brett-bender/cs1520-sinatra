# portfolio.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'pony'
require './message'

set :database, { adapter: "sqlite3", database: "portfolio.sqlite3" }

get '/' do
  erb :"index.html"
end

post '/contact' do

  # Copy needed parameters from the request
  locals = {}
  locals[:name] = params['name']
  locals[:email] = params['email']
  locals[:message] = params['message']
  locals[:subject] = params['subject']

  # build an object to be saved to the database
  message = Message.new locals

  # ensure it is properly built (logs to terminal)
  puts message.inspect

  # Validate and Save the object (SQL Insert)
  # Notice this short-circuits, so we won't try to save a message that isn't valid
  success = message.valid? && message.save

  if success
    if !params.key?('honeypot') || params['honeypot'].empty?
      # Render a view for the body of the email
      message_body = erb(:"_email-body.html", :locals => locals)

      # construct and send the email
      # This function returns a mail object.
      # See https://github.com/mikel/mail for details.
      email = Pony.mail :to => 'test@example.com',
                        :from => 'noreply@example.com',
                        :subject => "contact email from your website!",
                        :body => message_body

      # sends output to STDOUT (terminal where the process is run).
      # Debugging purposes only.

      mail_sent = email.error_status.empty?
      puts email
    end
  end

  # everything went ok, back to the homepage
  if success && mail_sent
    redirect '/'
  else
    # Render an error page, informing them of the errors
    erb :'contact-error.html', :locals =>  { :errors => message.errors }
  end
end

helpers do
  # returns an array of hashes representing social media information
  def social_media
    twitter = { :name => 'Twitter',
                :url => 'https://www.twitter.com/beardedstudio' }
    github = { :name => 'Github',
               :url => 'https://www.github.com/brett-bender' }
    internet = {  :name => 'Website',
                  :url => 'http://www.bearded.com'}

    [internet, twitter, github]
  end
end
