require 'sinatra'
require 'rest_client'
require 'yaml'

require './bootstrap'
require './authorization'
require './models'

get '/' do
  protected!

  @contacts = Contact.all

  erb :index
end

get '/form' do
  response['X-Frame-Options'] = 'DOIT'

  erb :form, :layout => :'iframe'
end

post '/send' do

  response['X-Frame-Options'] = 'DOIT'

  @contact = Contact.new(params)
  @contact.save

  RestClient.post 'https://api.elasticemail.com/mailer/send',
    :username  => settings.mail['username'],
    :api_key   => settings.mail['api_key'],
    :from      => @contact.email_address,
    :from_name => "#{@contact.full_name}",
    :to        => settings.mail['to'],
    :subject   => @contact.interest,
    :body_html => @contact.message
end
